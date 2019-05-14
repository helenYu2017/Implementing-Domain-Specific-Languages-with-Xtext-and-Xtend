/*
 * generated by Xtext 2.10.0
 */
package org.example.xbase.expressions.validation

import org.eclipse.xtext.xbase.XExpression
import org.example.xbase.expressions.expressions.EvalExpression

/**
 * This class contains custom validation rules. 
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#validation
 */
class ExpressionsValidator extends AbstractExpressionsValidator {

	override protected isValueExpectedRecursive(XExpression expr) {
		return expr.eContainer instanceof EvalExpression || super.isValueExpectedRecursive(expr)
	}

}