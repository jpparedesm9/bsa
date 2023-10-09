package com.cobis.cloud.sofom.service.oxxo.anotations;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface OxxoValidation {
	public boolean required();
	public DataType dataType();
	public int maxlength();
	public boolean date() default false;

}
