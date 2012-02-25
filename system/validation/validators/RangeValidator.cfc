/**
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************
The ColdBox validator interface, all inspired by awesome Hyrule Validation Framework by Dan Vega
*/
component accessors="true"{

	property name="name";
	
	SizeValidator function init(){
		name = "Range";	
		return this;
	}

	/**
	* Will check if an incoming value validates
	* @validationResult.hint The result object of the validation
	* @target.hint The target object to validate on
	* @field.hint The field on the target object to validate on
	* @targetValue.hint The target value to validate
	* @validationData.hint The validation data the validator was created with
	*/
	boolean function validate(required coldbox.system.validation.result.IValidationResult validationResult, required any target, required string field, any targetValue, string validationData){
		// check
		if( !isValid("string",arguments.validationData) || !isValid("regex",arguments.validationData,"(\-?\d)+\.\.\-?\d+")){
			throw(message="The Required validator data needs to be boolean and you sent in: #arguments.validationData#",type="RequiredValidator.InvalidValidationData");
		}
		
		var min = listFirst( arguments.validationData,'..');
		var max = "";
		if( find("..",arguments.validationData) ){
			max = listLast( arguments.validationData,'..');
		}
		
		// simple value range evaluations?
		if( targetValue >= min AND ( !len(max) OR targetValue <= max ) ) {
			return true;
		}
		
		var args = {message="The '#arguments.field#' value is not the value field range (#arguments.validationData#)",field=arguments.field};
		validationResult.addError( validationResult.newError(argumentCollection=args) );
		return false;
	}
	
	/**
	* Get the name of the validator
	*/
	string function getName(){
		return name;
	}
	
}