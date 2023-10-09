package com.cobiscorp.ecobis.htm.test.api.util.dtos;

import java.sql.Types;

public class SybTypes {
		// Constants
		/** Constante para el tipo de dato Binary */
		public static final int SYBBINARY = 0x2D;

		/** Constante para el tipo de dato Bit */
		public static final int SYBBIT = 0x32;

		/** Constante para el tipo de dato Char */
		public static final int SYBCHAR = 0x2F;

		/** Constante para el tipo de dato DateTime4 */
		public static final int SYBDATETIME4 = 0x3A;

		/** Constante para el tipo de dato DateTime */
		public static final int SYBDATETIME = 0x3D;

		/** Constante para el tipo de dato DateTimn */
		public static final int SYBDATETIMN = 0x6F;

		/** Constante para el tipo de dato Decimal */
		public static final int SYBDECIMAL = 0x6A;

		/** Constante para el tipo de dato FLT8i */
		public static final int SYBFLT8i = 0x3E;

		/** Constante para el tipo de dato FLTNi */
		public static final int SYBFLTNi = 0x6D;

		/** Constante para el tipo de dato Real */
		public static final int SYBREAL = 0x3B;

		/** Constante para el tipo de dato Image */
		public static final int SYBIMAGE = 0x22;

		/** Constante para el tipo de dato Int1 */
		public static final int SYBINT1 = 0x30;

		/** Constante para el tipo de dato Int2 */
		public static final int SYBINT2 = 0x34;

		/** Constante para el tipo de dato Int4 */
		public static final int SYBINT4 = 0x38;

		/** Constante para el tipo de dato Intn */
		public static final int SYBINTN = 0x26;

		/** Constante para el tipo de dato LongBinary */
		public static final int SYBLONGBINARY = 0xE1;

		/** Constante para el tipo de dato LongChar */
		public static final int SYBLONGCHAR = 0xAF;

		/** Constante para el tipo de dato Money4 */
		public static final int SYBMONEY4 = 0x7A;

		/** Constante para el tipo de dato Money */
		public static final int SYBMONEY = 0x3C;

		/** Constante para el tipo de dato Moneyn */
		public static final int SYBMONEYN = 0x6E;

		/** Constante para el tipo de dato Numeric */
		public static final int SYBNUMERIC = 0x6C;

		/** Constante para el tipo de dato Text */
		public static final int SYBTEXT = 0x23;

		/** Constante para el tipo de dato VarBinary */
		public static final int SYBVARBINARY = 0x25;

		/** Constante para el tipo de dato Varchar */
		public static final int SYBVARCHAR = 0x27;

		/** Constante para el tipo de dato SQLBinary */
		public static final int SQLBINARY = 0x2D;

		/** Constante para el tipo de dato SQLBit */
		public static final int SQLBIT = 0x32;

		/** Constante para el tipo de dato SQLChar */
		public static final int SQLCHAR = 0x2F;

		/** Constante para el tipo de dato SQLDateTime4 */
		public static final int SQLDATETIME4 = 0x3A;

		/** Constante para el tipo de dato SQLDateTime */
		public static final int SQLDATETIME = 0x3D;

		/** Constante para el tipo de dato SQLDateTimn */
		public static final int SQLDATETIMN = 0x6F;

		/** Constante para el tipo de dato SQLDecimal */
		public static final int SQLDECIMAL = 0x6A;

		/** Constante para el tipo de dato SQLFLT8i */
		public static final int SQLFLT8i = 0x3E;

		/** Constante para el tipo de dato FLTNi */
		public static final int SQLFLTNi = 0x6D;

		/** Constante para el tipo de dato SQLReal */
		public static final int SQLREAL = 0x3B;

		/** Constante para el tipo de dato SQLImage */
		public static final int SQLIMAGE = 0x22;

		/** Constante para el tipo de dato SQLInt1 */
		public static final int SQLINT1 = 0x30;

		/** Constante para el tipo de dato SQLInt2 */
		public static final int SQLINT2 = 0x34;

		/** Constante para el tipo de dato SQLInt4 */
		public static final int SQLINT4 = 0x38;

		/** Constante para el tipo de dato SQLIntn */
		public static final int SQLINTN = 0x26;

		/** Constante para el tipo de dato SQLLongBinary */
		public static final int SQLLONGBINARY = 0xE1;

		/** Constante para el tipo de dato SQLLongChar */
		public static final int SQLLONGCHAR = 0xAF;

		/** Constante para el tipo de dato SQLMoney4 */
		public static final int SQLMONEY4 = 0x7A;

		/** Constante para el tipo de dato SQLMoney */
		public static final int SQLMONEY = 0x3C;

		/** Constante para el tipo de dato SQLMoneyn */
		public static final int SQLMONEYN = 0x6E;

		/** Constante para el tipo de dato SQLNumeric */
		public static final int SQLNUMERIC = 0x6C;

		/** Constante para el tipo de dato SQLText */
		public static final int SQLTEXT = 0x23;

		/** Constante para el tipo de dato SQLVarBinary */
		public static final int SQLVARBINARY = 0x25;

		/** Constante para el tipo de dato SQLVarchar */
		public static final int SQLVARCHAR = 0x27;
		
		public static int mapSyb2JDBCTypes(int sybType) {
			switch (sybType) {
			case SybTypes.SYBCHAR:
				return Types.CHAR;
			case SybTypes.SYBVARCHAR:
				return Types.VARCHAR;
			case SybTypes.SYBLONGCHAR:
			case SybTypes.SYBTEXT:
				return Types.LONGVARCHAR;
			case SybTypes.SYBBIT:
				return Types.BIT;
			case SybTypes.SYBBINARY:
				return Types.BINARY;
			case SybTypes.SYBVARBINARY:
				return Types.VARBINARY;
			case SybTypes.SYBLONGBINARY:
			case SybTypes.SYBIMAGE:
				return Types.LONGVARBINARY;
			case SybTypes.SYBDATETIME4:
			case SybTypes.SYBDATETIME:
			case SybTypes.SYBDATETIMN:
				return Types.VARCHAR;
			case SybTypes.SYBDECIMAL:
				return Types.DECIMAL;
			case SybTypes.SYBNUMERIC:
				return Types.NUMERIC;
			case SybTypes.SYBFLT8i:
			case SybTypes.SYBFLTNi:
				return Types.FLOAT;
			case SybTypes.SYBREAL:
				return Types.REAL;
			case SybTypes.SYBINT1:
				return Types.TINYINT;
			case SybTypes.SYBINT2:
				return Types.SMALLINT;
			case SybTypes.SYBINT4:
			case SybTypes.SYBINTN:
				return Types.INTEGER;
			case SybTypes.SYBMONEY4:
			case SybTypes.SYBMONEY:
			case SybTypes.SYBMONEYN:
				return Types.FLOAT;
			default:
				return Types.VARCHAR;
			}
		}

		/**
		 * Mapea los tipos de datos JDBC a DB-Library Sybase.
		 * 
		 * @param jdbcType tipo de dato JDBC.
		 * @return tipo de dato DB-Library Sybase.
		 */
		public static int mapJDBC2SybTypes(int jdbcType) {
			switch (jdbcType) {
			case Types.CHAR:
				return SybTypes.SYBCHAR;
			case Types.VARCHAR:
				return SybTypes.SYBVARCHAR;
			case Types.LONGVARCHAR:
				return SybTypes.SYBTEXT;
			case Types.BIT:
				return SybTypes.SYBBIT;
			case Types.BINARY:
				return SybTypes.SYBBINARY;
			case Types.VARBINARY:
				return SybTypes.SYBVARBINARY;
			case Types.LONGVARBINARY:
				return SybTypes.SYBIMAGE;
			case Types.DATE:
			case Types.TIMESTAMP:
			case Types.TIME:
				return SybTypes.SYBDATETIME;
			case Types.DECIMAL:
				return SybTypes.SYBMONEY; //SYBDECIMAL
			case Types.NUMERIC:
				return SybTypes.SYBNUMERIC;
			case Types.FLOAT:
			case Types.DOUBLE:
				return SybTypes.SYBFLT8i;
			case Types.REAL:
				return SybTypes.SYBREAL;
			case Types.TINYINT:
				return SybTypes.SYBINT1;
			case Types.SMALLINT:
				return SybTypes.SYBINT2;
			case Types.INTEGER:
				return SybTypes.SYBINT4;
			default:
				return SybTypes.SYBVARCHAR;
			}
		}
}
