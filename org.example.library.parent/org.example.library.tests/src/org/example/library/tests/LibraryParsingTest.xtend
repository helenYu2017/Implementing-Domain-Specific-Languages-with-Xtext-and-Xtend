/*
 * generated by Xtext 2.10.0
 */
package org.example.library.tests

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.example.library.Book
import org.example.library.LibraryModel
import org.junit.Test
import org.junit.runner.RunWith

import static extension org.junit.Assert.*

@RunWith(XtextRunner)
@InjectWith(LibraryInjectorProvider)
class LibraryParsingTest {

	@Inject ParseHelper<LibraryModel> parseHelper
	@Inject extension ValidationTestHelper

	@Test
	def void loadModel() {
		val result = parseHelper.parse('''
			library "A library" {
				writers {
					"A writer", "Another writer", "Third writer"
				}
				books {
					title "A book",
					title "Another book"
						authors "Third writer", "A writer"
				}
			}
			
			library "An empty library" {
				
			}
		''')
		assertNotNull(result)
	}

	@Test
	def void testGetBooks() {
		val result = parseHelper.parse('''
			library "A library" {
				writers {
					"A writer", "Another writer", "Third writer"
				}
				books {
					title "A book"
						authors "A writer",
					title "Another book"
						authors "Third writer", "A writer"
				}
			}
		''')
		result.assertNoErrors
		result.libraries.head => [
			"A book, Another book".assertEquals(writers.get(0).books.booksToString)
			"".assertEquals(writers.get(1).books.booksToString)
			"Another book".assertEquals(writers.get(2).books.booksToString)
		]
	}

	@Test
	def void testBookCustomToString() {
		val result = parseHelper.parse('''
			library "A library" {
				writers {
					"A writer", "Another writer", "Third writer"
				}
				books {
					title "A book"
						authors "A writer", "Another writer"
				}
			}
		''')
		result.assertNoErrors
		result.libraries.head => [
			'title: "A book", by A writer, Another writer'.assertEquals(books.head.toString)
		]
	}

	def private booksToString(Iterable<Book> books) {
		books.map[title].join(", ")
	}
}