Use cob_conta
go

IF OBJECT_ID ('dbo.cb_plan_general') IS NOT NULL
	DROP TABLE dbo.cb_plan_general
GO

CREATE TABLE dbo.cb_plan_general
	(
	pg_empresa TINYINT NOT NULL,
	pg_cuenta  cuenta_contable NOT NULL,
	pg_oficina SMALLINT NOT NULL,
	pg_area    SMALLINT NOT NULL,
	pg_clave   VARCHAR (30) COLLATE Latin1_General_BIN NULL
	)
GO

CREATE UNIQUE NONCLUSTERED INDEX cb_plan_general_Key
	ON dbo.cb_plan_general (pg_cuenta,pg_oficina,pg_area)
GO

CREATE NONCLUSTERED INDEX i_clave
	ON dbo.cb_plan_general (pg_clave)
GO

CREATE NONCLUSTERED INDEX i_pg_cuenta
	ON dbo.cb_plan_general (pg_oficina,pg_area)
GO

CREATE NONCLUSTERED INDEX i_pg_cuenta2
	ON dbo.cb_plan_general (pg_area)
GO




INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14891000005', 7020, 31, '114891000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14891500005', 7020, 31, '114891500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14892000005', 7020, 31, '114892000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14892500005', 7020, 31, '114892500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16050600005', 7020, 31, '116050600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16050800005', 7020, 31, '116050800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16051200005', 7020, 31, '116051200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16051400005', 7020, 31, '116051400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16051600005', 7020, 31, '116051600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16050800010', 7020, 31, '116050800010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16051200010', 7020, 31, '116051200010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16361000005', 7020, 31, '116361000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16360500005', 7020, 31, '116360500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16361500005', 7020, 31, '116361500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82842600005', 7020, 31, '182842600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16052800010', 7020, 31, '116052800010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14912200005', 7020, 31, '114912200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500085', 7020, 31, '151701500085702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82842800005', 7020, 31, '182842800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16991000063', 7020, 31, '116991000063702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14040500005', 7020, 31, '114040500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14041000005', 7020, 31, '114041000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14041500005', 7020, 31, '114041500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14042000005', 7020, 31, '114042000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14890500005', 7020, 31, '114890500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14042500005', 7020, 31, '114042500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14603000010', 7020, 31, '114603000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82132000020', 7020, 31, '182132000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52950500005', 7020, 31, '152950500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51554000005', 7020, 31, '151554000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51559500900', 7020, 31, '151559500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500025', 7020, 31, '142959500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500055', 7020, 31, '151409500055702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25957000036', 7020, 31, '125957000036702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '21150500010', 7020, 31, '121150500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '24101000010', 7020, 31, '124101000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28102500005', 7020, 31, '128102500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '24130000010', 7020, 31, '124130000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500010', 7020, 19, '127049500010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '62959500015', 7020, 31, '162959500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241800022', 7020, 31, '182241800022702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241500022', 7020, 31, '182241500022702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42251300015', 7020, 31, '142251300015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500055', 7020, 31, '142959500055702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19999500025', 7020, 31, '119999500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '21151500010', 7020, 31, '121151500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51559500030', 7020, 31, '151559500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51030400010', 7020, 31, '151030400010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '24130000005', 7020, 31, '124130000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25051500015', 7020, 31, '125051500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41049500800', 7020, 31, '141049500800702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500135', 7020, 31, '142259500135702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51020600010', 7020, 31, '151020600010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500041', 7020, 31, '116879500041702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000070', 7020, 31, '119151000070702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500810', 7020, 29, '127049500810702029')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51154300500', 7020, 31, '151154300500702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '54050500006', 7020, 31, '154050500006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500810', 7020, 28, '127049500810702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500011', 7020, 31, '116879500011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802500026', 7020, 31, '151802500026702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802500031', 7020, 31, '151802500031702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27950500017', 7020, 31, '127950500017702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51020500010', 7020, 31, '151020500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '61959500015', 7020, 31, '161959500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51020700010', 7020, 31, '151020700010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904500010', 7020, 31, '151904500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '62250500800', 7020, 31, '162250500800702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '21153000010', 7020, 31, '121153000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '21152500010', 7020, 31, '121152500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51459500900', 7020, 31, '151459500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81701500005', 7020, 31, '181701500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81959500020', 7020, 31, '181959500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500997', 7020, 31, '127049500997702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500800', 7020, 31, '119049500800702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500913', 7020, 31, '151909500913702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500800', 7020, 31, '127049500800702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16984500006', 7020, 31, '116984500006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51704000010', 7020, 31, '151704000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500030', 7020, 31, '142959500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41070600166', 7020, 31, '141070600166702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500125', 7020, 31, '151709500125702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16059500165', 7020, 31, '116059500165702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '61250500800', 7020, 31, '161250500800702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500025', 7020, 31, '151159500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19041000005', 7020, 30, '119041000005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51500500900', 7020, 31, '151500500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82621500005', 7020, 31, '182621500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41353501005', 7020, 31, '141353501005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51459500901', 7020, 31, '151459500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600026', 7020, 31, '151209600026702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500815', 7020, 31, '127049500815702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500810', 7020, 31, '127049500810702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500150', 7020, 31, '141159500150702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500805', 7020, 31, '127049500805702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000001005', 7020, 15, '136000001005702015')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19153500007', 7020, 31, '119153500007702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 37, '136000000005702037')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 36, '136000000005702036')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 35, '136000000005702035')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 33, '136000000005702033')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 32, '136000000005702032')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 29, '136000000005702029')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 27, '136000000005702027')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 26, '136000000005702026')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 25, '136000000005702025')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 24, '136000000005702024')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 21, '136000000005702021')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 23, '136000000005702023')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 20, '136000000005702020')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 19, '136000000005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 17, '136000000005702017')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 16, '136000000005702016')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 12, '136000000005702012')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 15, '136000000005702015')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 14, '136000000005702014')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 13, '136000000005702013')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 11, '136000000005702011')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 9, '13600000000570209')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 2, '13600000000570202')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 10, '136000000005702010')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 7, '13600000000570207')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 8, '13600000000570208')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 6, '13600000000570206')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51030400005', 7020, 31, '151030400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 5, '13600000000570205')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 4, '13600000000570204')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 3, '13600000000570203')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 1, '13600000000570201')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27044000005', 7020, 18, '127044000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500118', 7020, 31, '142259500118702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19205500006', 7020, 31, '119205500006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19204500021', 7020, 31, '119204500021702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51601000005', 7020, 31, '151601000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 31, '136000000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '32100000005', 7020, 31, '132100000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28959500020', 7020, 31, '128959500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51204500800', 7020, 31, '151204500800702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500035', 7020, 31, '151159500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207000015', 7020, 31, '151207000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '13131100010', 7020, 31, '113131100010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '24100500005', 7020, 31, '124100500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000902', 7020, 34, '151903000902702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500020', 7020, 34, '151159500020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000035', 7020, 34, '151903000035702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500408', 7020, 30, '125550500408702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500407', 7020, 30, '125550500407702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500406', 7020, 30, '125550500406702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '24300500005', 7020, 31, '124300500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500201', 7020, 34, '152959500201702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51601000010', 7020, 34, '151601000010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500030', 7020, 34, '151903500030702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301500005', 7020, 31, '125301500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51509500030', 7020, 34, '151509500030702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500016', 7020, 34, '151309500016702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500405', 7020, 30, '125550500405702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51801000006', 7020, 18, '151801000006702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51801500006', 7020, 18, '151801500006702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500130', 7020, 34, '142259500130702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500130', 7020, 31, '142259500130702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51039500010', 7020, 31, '151039500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51039500015', 7020, 31, '151039500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51402500005', 7020, 31, '151402500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500060', 7020, 31, '151909500060702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51039501005', 7020, 31, '151039501005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28959500010', 7020, 34, '128959500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201500045', 7020, 31, '181201500045702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51039500020', 7020, 31, '151039500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28959500006', 7020, 34, '128959500006702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500400', 7020, 34, '151909500400702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '61100000005', 7020, 34, '161100000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25100500005', 7020, 31, '125100500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28959500015', 7020, 34, '128959500015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '61100500005', 7020, 28, '161100500005702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201800040', 7020, 31, '181201800040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241000005', 7020, 31, '182241000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241300005', 7020, 31, '182241300005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16559500015', 7020, 31, '116559500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81050500035', 7020, 34, '181050500035702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201800030', 7020, 31, '181201800030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500201', 7020, 31, '152959500201702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500010', 7020, 34, '127049500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500400', 7020, 31, '151901500400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500096', 7020, 31, '151909500096702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500206', 7020, 34, '152959500206702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16381500901', 7020, 31, '116381500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16382000010', 7020, 31, '16382000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16382000105', 7020, 31, '16382000105702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16382000110', 7020, 31, '16382000110702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16382000115', 7020, 31, '16382000115702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16382000200', 7020, 31, '16382000200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16382000205', 7020, 31, '116382000205702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16382000900', 7020, 31, '16382000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16382000901', 7020, 31, '116382000901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16382500010', 7020, 31, '16382500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16382500105', 7020, 31, '16382500105702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16382500110', 7020, 31, '16382500110702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16382500115', 7020, 31, '16382500115702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16382500200', 7020, 31, '16382500200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16382500205', 7020, 31, '116382500205702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16382500900', 7020, 31, '16382500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16382500901', 7020, 31, '116382500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16390500010', 7020, 31, '16390500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16390500105', 7020, 31, '16390500105702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16390500110', 7020, 31, '16390500110702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16390500115', 7020, 31, '16390500115702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16390500200', 7020, 31, '16390500200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16390500205', 7020, 31, '116390500205702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16390500900', 7020, 31, '16390500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16390500901', 7020, 31, '116390500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16391000010', 7020, 31, '16391000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16391000105', 7020, 31, '16391000105702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16391000110', 7020, 31, '16391000110702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16391000115', 7020, 31, '16391000115702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16391000200', 7020, 31, '16391000200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16391000205', 7020, 31, '116391000205702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16391000900', 7020, 31, '16391000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16391000901', 7020, 31, '116391000901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16391500010', 7020, 31, '16391500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16391500105', 7020, 31, '16391500105702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16391500110', 7020, 31, '16391500110702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16391500115', 7020, 31, '16391500115702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16391500200', 7020, 31, '16391500200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16391500205', 7020, 31, '116391500205702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16391500900', 7020, 31, '16391500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16391500901', 7020, 31, '116391500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16392000010', 7020, 31, '16392000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16392000105', 7020, 31, '16392000105702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16392000110', 7020, 31, '16392000110702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16392000115', 7020, 31, '16392000115702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16392000200', 7020, 31, '16392000200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16392000205', 7020, 31, '116392000205702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16392000900', 7020, 31, '16392000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16392000901', 7020, 31, '116392000901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16392500010', 7020, 31, '16392500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16392500105', 7020, 31, '16392500105702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16392500110', 7020, 31, '16392500110702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16392500115', 7020, 31, '16392500115702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16392500200', 7020, 31, '16392500200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16392500205', 7020, 31, '116392500205702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16392500900', 7020, 31, '16392500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16392500901', 7020, 31, '116392500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16550500005', 7020, 31, '116550500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16551000005', 7020, 31, '116551000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16551000015', 7020, 31, '116551000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16559500005', 7020, 31, '116559500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16559500010', 7020, 31, '116559500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16871000005', 7020, 31, '16871000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16871500005', 7020, 31, '16871500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16871500010', 7020, 31, '116871500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16872000005', 7020, 31, '16872000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16872000010', 7020, 31, '116872000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500005', 7020, 31, '116879500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500009', 7020, 31, '116879500009702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500010', 7020, 31, '116879500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500015', 7020, 31, '116879500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500020', 7020, 31, '116879500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500025', 7020, 31, '116879500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500030', 7020, 31, '116879500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500080', 7020, 31, '116879500080702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500085', 7020, 31, '116879500085702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500700', 7020, 31, '116879500700702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500771', 7020, 31, '116879500771702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500772', 7020, 31, '116879500772702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500773', 7020, 31, '116879500773702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500774', 7020, 31, '116879500774702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500775', 7020, 31, '116879500775702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500776', 7020, 31, '116879500776702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19209500010', 7020, 18, '119209500010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19042000090', 7020, 19, '119042000090702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51809500010', 7020, 18, '151809500010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51302500011', 7020, 34, '151302500011702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500954', 7020, 31, '127049500954702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241500030', 7020, 31, '182241500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241800025', 7020, 31, '182241800025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500030', 7020, 30, '151409500030702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500955', 7020, 31, '127049500955702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802000006', 7020, 31, '151802000006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51800500006', 7020, 31, '151800500006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403500020', 7020, 31, '151403500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500021', 7020, 31, '142259500021702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500206', 7020, 31, '152959500206702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19201000010', 7020, 18, '119201000010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500201', 7020, 18, '151901500201702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802500006', 7020, 18, '151802500006702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241500015', 7020, 31, '182241500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51509500400', 7020, 34, '151509500400702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241800005', 7020, 31, '182241800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403500025', 7020, 30, '151403500025702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403500025', 7020, 31, '151403500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403500025', 7020, 34, '151403500025702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19204500006', 7020, 18, '119204500006702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '61100000005', 7020, 28, '161100000005702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000400', 7020, 34, '151904000400702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '61100500005', 7020, 34, '161100500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '62100000005', 7020, 34, '162100000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51601000400', 7020, 34, '151601000400702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25309500025', 7020, 30, '125309500025702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19201500015', 7020, 18, '119201500015702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '21200500005', 7020, 31, '121200500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241300015', 7020, 31, '182241300015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '21200800005', 7020, 31, '121200800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '62100000005', 7020, 28, '162100000005702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '21200500010', 7020, 31, '121200500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25309500025', 7020, 34, '125309500025702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25309500025', 7020, 31, '125309500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '21200800015', 7020, 31, '121200800015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19204500011', 7020, 18, '119204500011702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '21200800010', 7020, 31, '121200800010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500400', 7020, 34, '151309500400702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500056', 7020, 31, '116879500056702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500932', 7020, 31, '119049500932702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500933', 7020, 31, '119049500933702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500205', 7020, 31, '152959500205702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500931', 7020, 31, '119049500931702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500420', 7020, 31, '125550500420702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19204500026', 7020, 18, '119204500026702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151500015', 7020, 34, '119151500015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241300035', 7020, 31, '182241300035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51609500015', 7020, 34, '151609500015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500050', 7020, 34, '116989500050702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42250500045', 7020, 31, '142250500045702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82863000005', 7020, 31, '182863000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82870200005', 7020, 31, '182870200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82870400005', 7020, 31, '182870400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82870600005', 7020, 31, '182870600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82870800005', 7020, 31, '182870800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82871000005', 7020, 31, '182871000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82871200005', 7020, 31, '182871200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82871400005', 7020, 31, '182871400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82871600005', 7020, 31, '182871600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82871800005', 7020, 31, '182871800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82872000005', 7020, 31, '182872000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82872200005', 7020, 31, '182872200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82872400005', 7020, 31, '182872400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82872600005', 7020, 31, '182872600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82872800005', 7020, 31, '182872800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82873000005', 7020, 31, '182873000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82880200005', 7020, 31, '182880200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82880400005', 7020, 31, '182880400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82880600005', 7020, 31, '182880600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82880800005', 7020, 31, '182880800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82881000005', 7020, 31, '182881000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82881200005', 7020, 31, '182881200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82881400005', 7020, 31, '182881400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82881600005', 7020, 31, '182881600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82881800005', 7020, 31, '182881800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82882000005', 7020, 31, '182882000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82882200005', 7020, 31, '182882200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82882400005', 7020, 31, '182882400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82882600005', 7020, 31, '182882600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82882800005', 7020, 31, '182882800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82883000005', 7020, 31, '182883000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82959500010', 7020, 31, '182959500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82959500085', 7020, 31, '182959500085702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '83050000005', 7020, 31, '183050000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '84050000005', 7020, 31, '184050000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '84050001005', 7020, 31, '184050001005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500015', 7020, 32, '151159500015702032')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209500020', 7020, 32, '151209500020702032')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52101500005', 7020, 32, '52101500005702032')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 32, '159000000005702032')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 32, '159000001005702032')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 33, '159000000005702033')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 33, '159000001005702033')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500050', 7020, 34, '111150500050702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11950000005', 7020, 34, '111950000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14980500005', 7020, 34, '114980500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16102500005', 7020, 34, '116102500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16102500010', 7020, 34, '116102500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16102500015', 7020, 34, '116102500015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16250500005', 7020, 34, '116250500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16551000015', 7020, 34, '116551000015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16559500005', 7020, 34, '116559500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16559500010', 7020, 34, '116559500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16872000010', 7020, 34, '116872000010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500006', 7020, 34, '116879500006702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500009', 7020, 34, '116879500009702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500035', 7020, 34, '116879500035702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500040', 7020, 34, '116879500040702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500050', 7020, 34, '116879500050702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500055', 7020, 34, '116879500055702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500056', 7020, 34, '116879500056702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500060', 7020, 34, '116879500060702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16984500005', 7020, 34, '116984500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16984500006', 7020, 34, '116984500006702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16985500015', 7020, 34, '116985500015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16985500016', 7020, 34, '116985500016702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500005', 7020, 34, '116989500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500006', 7020, 34, '116989500006702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500010', 7020, 34, '116989500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500011', 7020, 34, '116989500011702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500015', 7020, 34, '116989500015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500016', 7020, 34, '116989500016702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500020', 7020, 34, '116989500020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500021', 7020, 34, '116989500021702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500035', 7020, 34, '116989500035702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500040', 7020, 34, '116989500040702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500045', 7020, 34, '116989500045702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '18990500005', 7020, 34, '118990500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '18990500006', 7020, 34, '118990500006702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19040500005', 7020, 34, '119040500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19041000010', 7020, 34, '119041000010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19041500005', 7020, 34, '119041500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500011', 7020, 34, '151909500011702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '21200800020', 7020, 31, '121200800020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51554500005', 7020, 34, '151554500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500901', 7020, 31, '151309500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241300020', 7020, 31, '182241300020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500903', 7020, 31, '151309500903702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500011', 7020, 31, '151909500011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500934', 7020, 31, '119049500934702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500931', 7020, 19, '119049500931702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500901', 7020, 31, '127049500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500400', 7020, 34, '151903500400702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500009', 7020, 34, '116989500009702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000900', 7020, 31, '151701000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500903', 7020, 31, '127049500903702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500902', 7020, 31, '127049500902702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500009', 7020, 31, '116989500009702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500009', 7020, 19, '116989500009702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500935', 7020, 31, '119049500935702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500936', 7020, 31, '119049500936702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500932', 7020, 31, '127049500932702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51704000006', 7020, 31, '151704000006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500904', 7020, 31, '127049500904702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51450500400', 7020, 34, '151450500400702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500905', 7020, 31, '127049500905702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500950', 7020, 31, '127049500950702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500931', 7020, 31, '127049500931702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500906', 7020, 31, '127049500906702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19042000080', 7020, 46, '119042000080702046')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500907', 7020, 31, '127049500907702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19041500005', 7020, 46, '119041500005702046')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19150500005', 7020, 31, '119150500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500933', 7020, 31, '127049500933702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500951', 7020, 31, '119049500951702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27702000005', 7020, 31, '127702000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500104', 7020, 18, '119909500104702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25050500010', 7020, 31, '125050500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500936', 7020, 19, '119049500936702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500194', 7020, 18, '119909500194702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500035', 7020, 31, '151309500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51039500005', 7020, 31, '151039500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14593000', 7020, 31, '114593000702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14593000005', 7020, 31, '114593000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500952', 7020, 31, '119049500952702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201300005', 7020, 31, '181201300005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14603000005', 7020, 31, '114603000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27702000015', 7020, 31, '127702000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500951', 7020, 31, '127049500951702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500952', 7020, 31, '127049500952702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14633000005', 7020, 31, '114633000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28050500005', 7020, 31, '128050500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14623000005', 7020, 31, '114623000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241800030', 7020, 31, '182241800030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500953', 7020, 31, '127049500953702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500991', 7020, 31, '127049500991702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901000400', 7020, 22, '151901000400702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500992', 7020, 31, '127049500992702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500990', 7020, 31, '127049500990702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41049500010', 7020, 31, '141049500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28050500015', 7020, 31, '128050500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241500025', 7020, 31, '182241500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14673000005', 7020, 31, '114673000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241500020', 7020, 31, '182241500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14653000005', 7020, 31, '114653000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14663000005', 7020, 31, '114663000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500060', 7020, 31, '141159500060702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14683000005', 7020, 31, '114683000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500062', 7020, 31, '141159500062702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241800020', 7020, 31, '182241800020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241800015', 7020, 31, '182241800015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500996', 7020, 31, '127049500996702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51200500400', 7020, 22, '151200500400702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500996', 7020, 30, '127049500996702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241800010', 7020, 31, '182241800010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500900', 7020, 31, '151903500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500064', 7020, 31, '141159500064702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500206', 7020, 31, '142959500206702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500995', 7020, 30, '127049500995702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500066', 7020, 31, '141159500066702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14693000005', 7020, 31, '114693000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51020200005', 7020, 31, '151020200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51020200010', 7020, 31, '151020200010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51020200015', 7020, 31, '151020200015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14703000005', 7020, 31, '114703000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51020200020', 7020, 31, '151020200020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000903', 7020, 31, '151903000903702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25100500020', 7020, 30, '125100500020702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 5, '11904950000570205')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241300010', 7020, 31, '182241300010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51900500400', 7020, 31, '151900500400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41020700005', 7020, 31, '141020700005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904500400', 7020, 31, '151904500400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19042000080', 7020, 4, '11904200008070204')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500035', 7020, 4, '15130950003570204')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500020', 7020, 4, '5190950002070204')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 4, '15900000000570204')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 4, '15900000100570204')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19042000080', 7020, 5, '11904200008070205')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700005', 7020, 5, '5120970000570205')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309700005', 7020, 5, '5130970000570205')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409700005', 7020, 5, '5140970000570205')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51459700005', 7020, 5, '5145970000570205')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51559700005', 7020, 5, '5155970000570205')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51609700005', 7020, 5, '5160970000570205')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51659700005', 7020, 5, '5165970000570205')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909700005', 7020, 5, '5190970000570205')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52109700005', 7020, 5, '5210970000570205')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 5, '15900000000570205')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 5, '15900000100570205')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19041500005', 7020, 1, '11904150000570201')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 1, '15900000000570201')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 1, '15900000100570201')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 3, '15900000000570203')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 3, '15900000100570203')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 2, '15900000000570202')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 2, '15900000100570202')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 6, '15900000000570206')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 6, '15900000100570206')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41900500005', 7020, 7, '14190050000570207')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41901000005', 7020, 7, '14190100000570207')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 7, '15900000000570207')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 7, '15900000100570207')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 8, '15900000000570208')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 8, '15900000100570208')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 9, '15900000000570209')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 9, '15900000100570209')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 10, '159000000005702010')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 10, '159000001005702010')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 11, '159000000005702011')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 11, '159000001005702011')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 13, '159000000005702013')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 13, '159000001005702013')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 12, '159000000005702012')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 12, '159000001005702012')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19041500005', 7020, 17, '119041500005702017')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19042000080', 7020, 17, '119042000080702017')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 17, '159000000005702017')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 17, '159000001005702017')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 14, '159000000005702014')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 14, '159000001005702014')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 15, '159000000005702015')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 15, '159000001005702015')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19042000080', 7020, 16, '119042000080702016')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19201500020', 7020, 16, '119201500020702016')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51801500020', 7020, 16, '151801500020702016')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 16, '159000000005702016')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 16, '159000001005702016')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16451000010', 7020, 18, '116451000010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16551000010', 7020, 18, '116551000010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16559500015', 7020, 18, '116559500015702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500055', 7020, 18, '116879500055702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500056', 7020, 18, '116879500056702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500940', 7020, 18, '16879500940702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '18100000005', 7020, 18, '18100000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '18150000005', 7020, 18, '18150000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '18200000005', 7020, 18, '18200000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '18250000005', 7020, 18, '18250000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '18300000005', 7020, 18, '18300000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '18951000005', 7020, 18, '118951000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '18952000005', 7020, 18, '18952000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19040500005', 7020, 18, '119040500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19041500005', 7020, 18, '19041500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19042000080', 7020, 18, '119042000080702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19042000090', 7020, 18, '119042000090702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 18, '119049500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500080', 7020, 18, '119049500080702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000055', 7020, 18, '119151000055702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000060', 7020, 18, '119151000060702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000065', 7020, 18, '119151000065702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151500010', 7020, 18, '119151500010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19153500005', 7020, 18, '119153500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19200500005', 7020, 18, '119200500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19201000005', 7020, 18, '119201000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19201500005', 7020, 18, '119201500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202000005', 7020, 18, '119202000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202500005', 7020, 18, '119202500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203000005', 7020, 18, '119203000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19204500005', 7020, 18, '119204500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19204500010', 7020, 18, '119204500010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19204500015', 7020, 18, '119204500015702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19204500020', 7020, 18, '119204500020702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19204500025', 7020, 18, '119204500025702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19204500030', 7020, 18, '119204500030702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19209500015', 7020, 18, '119209500015702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19903000005', 7020, 18, '19903000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500095', 7020, 18, '119909500095702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500096', 7020, 18, '119909500096702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500101', 7020, 18, '119909500101702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500190', 7020, 18, '119909500190702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500199', 7020, 18, '119909500199702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500930', 7020, 18, '119909500930702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25450000015', 7020, 18, '125450000015702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25450000020', 7020, 18, '125450000020702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500015', 7020, 18, '25959500015702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500030', 7020, 18, '125959500030702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500035', 7020, 18, '125959500035702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500070', 7020, 18, '125959500070702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500071', 7020, 18, '125959500071702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500700', 7020, 18, '125959500700702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500005', 7020, 18, '127049500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41500500005', 7020, 18, '41500500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41959500015', 7020, 18, '141959500015702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42100500005', 7020, 18, '42100500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42101000005', 7020, 18, '42101000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42101500005', 7020, 18, '42101500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42102000005', 7020, 18, '42102000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42102500005', 7020, 18, '42102500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500095', 7020, 18, '142259500095702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500096', 7020, 18, '142259500096702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500099', 7020, 18, '142959500099702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500100', 7020, 18, '142959500100702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500105', 7020, 18, '142959500105702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500110', 7020, 18, '142959500110702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51152000005', 7020, 18, '151152000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51208000005', 7020, 18, '151208000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51208000010', 7020, 18, '151208000010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51208000011', 7020, 18, '151208000011702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600025', 7020, 18, '151209600025702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700060', 7020, 18, '151209700060702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700135', 7020, 18, '151209700135702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500035', 7020, 18, '151309500035702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309700005', 7020, 18, '151309700005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51450500005', 7020, 18, '51450500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51451000005', 7020, 18, '51451000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51452000005', 7020, 18, '51452000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51453500005', 7020, 18, '51453500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51459500005', 7020, 18, '51459500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51459500010', 7020, 18, '151459500010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51459500020', 7020, 18, '151459500020702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51550500005', 7020, 18, '51550500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51551000005', 7020, 18, '51551000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51551500005', 7020, 18, '51551500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51552000005', 7020, 18, '51552000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51552500005', 7020, 18, '51552500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51553000005', 7020, 18, '51553000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51553500005', 7020, 18, '51553500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51554000005', 7020, 18, '51554000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51554500005', 7020, 18, '51554500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51555000005', 7020, 18, '51555000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51559500005', 7020, 18, '51559500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51559500015', 7020, 18, '151559500015702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51559500021', 7020, 18, '151559500021702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51600500005', 7020, 18, '51600500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51601000005', 7020, 18, '51601000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51601500005', 7020, 18, '51601500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51602000005', 7020, 18, '51602000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51603500005', 7020, 18, '51603500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51604000005', 7020, 18, '51604000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51609500005', 7020, 18, '51609500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51609500010', 7020, 18, '151609500010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51650500005', 7020, 18, '51650500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51651000005', 7020, 18, '51651000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51651500005', 7020, 18, '51651500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51651500010', 7020, 18, '151651500010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51704000006', 7020, 18, '151704000006702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51750500005', 7020, 18, '51750500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51751000005', 7020, 18, '51751000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51751500005', 7020, 18, '51751500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51752000005', 7020, 18, '51752000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51800500005', 7020, 18, '51800500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51801000005', 7020, 18, '51801000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51801500005', 7020, 18, '51801500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802000005', 7020, 18, '51802000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802500005', 7020, 18, '51802500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51809500005', 7020, 18, '51809500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51900500005', 7020, 18, '51900500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51900500010', 7020, 18, '51900500010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51900500015', 7020, 18, '51900500015702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51900500020', 7020, 18, '151900500020702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901000005', 7020, 18, '51901000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500005', 7020, 18, '51901500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500010', 7020, 18, '51901500010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500015', 7020, 18, '51901500015702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500020', 7020, 18, '51901500020702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500025', 7020, 18, '51901500025702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500030', 7020, 18, '51901500030702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500035', 7020, 18, '51901500035702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500060', 7020, 18, '151901500060702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902000005', 7020, 18, '51902000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500005', 7020, 18, '51902500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500010', 7020, 18, '51902500010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500015', 7020, 18, '51902500015702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500020', 7020, 18, '51902500020702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500025', 7020, 18, '51902500025702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500035', 7020, 18, '151902500035702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000005', 7020, 18, '51903000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500005', 7020, 18, '151903500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500010', 7020, 18, '151903500010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904500005', 7020, 18, '151904500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500005', 7020, 18, '51909500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500010', 7020, 18, '151909500010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500015', 7020, 18, '51909500015702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500025', 7020, 18, '51909500025702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500030', 7020, 18, '51909500030702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500035', 7020, 18, '51909500035702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500040', 7020, 18, '51909500040702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500045', 7020, 18, '51909500045702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500050', 7020, 18, '51909500050702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500055', 7020, 18, '51909500055702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500060', 7020, 18, '151909500060702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500065', 7020, 18, '151909500065702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909700010', 7020, 18, '151909700010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909700015', 7020, 18, '151909700015702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909700020', 7020, 18, '151909700020702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909700025', 7020, 18, '151909700025702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909700030', 7020, 18, '151909700030702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909700035', 7020, 18, '151909700035702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909700040', 7020, 18, '151909700040702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52100500005', 7020, 18, '52100500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52101000005', 7020, 18, '52101000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52101500005', 7020, 18, '52101500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52102000005', 7020, 18, '52102000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52102500005', 7020, 18, '52102500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52103000005', 7020, 18, '52103000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52172000005', 7020, 18, '52172000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52172500005', 7020, 18, '52172500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52173000005', 7020, 18, '52173000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 18, '159000000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 18, '159000001005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81701000005', 7020, 18, '81701000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81701500005', 7020, 18, '81701500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81702500005', 7020, 18, '81702500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '83050000005', 7020, 18, '183050000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11051000005', 7020, 19, '11051000005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11100500010', 7020, 19, '111100500010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500015', 7020, 19, '111150500015702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500050', 7020, 19, '11150500050702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500055', 7020, 19, '11150500055702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500060', 7020, 19, '11150500060702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500065', 7020, 19, '11150500065702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500070', 7020, 19, '11150500070702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500075', 7020, 19, '11150500075702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500080', 7020, 19, '11150500080702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500085', 7020, 19, '11150500085702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500090', 7020, 19, '11150500090702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500095', 7020, 19, '11150500095702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500100', 7020, 19, '11150500100702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500105', 7020, 19, '11150500105702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500110', 7020, 19, '11150500110702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500115', 7020, 19, '11150500115702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500120', 7020, 19, '11150500120702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500125', 7020, 19, '11150500125702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500130', 7020, 19, '11150500130702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500135', 7020, 19, '11150500135702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500140', 7020, 19, '11150500140702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500145', 7020, 19, '11150500145702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500175', 7020, 19, '111150500175702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500180', 7020, 19, '111150500180702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500185', 7020, 19, '111150500185702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500190', 7020, 19, '111150500190702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500195', 7020, 19, '111150500195702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500200', 7020, 19, '111150500200702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500205', 7020, 19, '111150500205702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500210', 7020, 19, '111150500210702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500215', 7020, 19, '111150500215702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500220', 7020, 19, '111150500220702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500225', 7020, 19, '111150500225702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500230', 7020, 19, '111150500230702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500240', 7020, 19, '111150500240702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500255', 7020, 19, '111150500255702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500260', 7020, 19, '111150500260702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500265', 7020, 19, '111150500265702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500270', 7020, 19, '111150500270702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11200000005', 7020, 19, '111200000005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11200000900', 7020, 19, '111200000900702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14561000005', 7020, 19, '114561000005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14561500005', 7020, 19, '114561500005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14570500005', 7020, 19, '114570500005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14571000005', 7020, 19, '114571000005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14571500005', 7020, 19, '114571500005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14572000005', 7020, 19, '114572000005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14572500005', 7020, 19, '114572500005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14598200005', 7020, 19, '114598200005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14608200005', 7020, 19, '114608200005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14668200005', 7020, 19, '114668200005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16053200005', 7020, 19, '116053200005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16053200010', 7020, 19, '116053200010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16053400005', 7020, 19, '116053400005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16053400010', 7020, 19, '116053400010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16053600005', 7020, 19, '116053600005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16053600010', 7020, 19, '116053600010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16053800005', 7020, 19, '116053800005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16053800010', 7020, 19, '116053800010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16054000005', 7020, 19, '116054000005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16054000010', 7020, 19, '116054000010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16054200005', 7020, 19, '116054200005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16054200010', 7020, 19, '116054200010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16054400005', 7020, 19, '116054400005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16054400010', 7020, 19, '116054400010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16054600005', 7020, 19, '116054600005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16054600010', 7020, 19, '116054600010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16054800005', 7020, 19, '116054800005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16054800010', 7020, 19, '116054800010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16109500005', 7020, 19, '116109500005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16109500040', 7020, 19, '116109500040702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16109500045', 7020, 19, '116109500045702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16109500050', 7020, 19, '116109500050702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16380500105', 7020, 19, '116380500105702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16381000105', 7020, 19, '116381000105702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16381500105', 7020, 19, '116381500105702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16382000105', 7020, 19, '116382000105702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16382500105', 7020, 19, '116382500105702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16390500105', 7020, 19, '116390500105702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16391000105', 7020, 19, '116391000105702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16871500005', 7020, 19, '116871500005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16871500010', 7020, 19, '116871500010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500600', 7020, 19, '116879500600702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500800', 7020, 19, '116879500800702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500995', 7020, 19, '116879500995702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19040500005', 7020, 19, '119040500005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 19, '119049500005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500778', 7020, 19, '119909500778702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500805', 7020, 19, '119909500805702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500810', 7020, 19, '119909500810702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500815', 7020, 19, '119909500815702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500820', 7020, 19, '119909500820702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500825', 7020, 19, '119909500825702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500830', 7020, 19, '119909500830702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500930', 7020, 19, '119909500930702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500960', 7020, 19, '119909500960702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '21651500005', 7020, 19, '21651500005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '21651500010', 7020, 19, '21651500010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '21651500030', 7020, 19, '121651500030702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000005', 7020, 19, '125350000005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500080', 7020, 19, '125959500080702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500600', 7020, 19, '125959500600702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500005', 7020, 19, '127049500005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27951500005', 7020, 19, '127951500005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27951500015', 7020, 19, '127951500015702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41020200005', 7020, 19, '141020200005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41020900005', 7020, 19, '141020900005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500005', 7020, 19, '141159500005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500025', 7020, 19, '141159500025702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500030', 7020, 19, '141159500030702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500035', 7020, 19, '141159500035702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500040', 7020, 19, '141159500040702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500045', 7020, 19, '141159500045702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500050', 7020, 19, '141159500050702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500011', 7020, 19, '142259500011702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51704000006', 7020, 19, '151704000006702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52951500005', 7020, 19, '152951500005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 19, '159000000005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 19, '159000001005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64304000005', 7020, 19, '164304000005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64304000010', 7020, 19, '164304000010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64304200005', 7020, 19, '164304200005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64304400005', 7020, 19, '164304400005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64304400010', 7020, 19, '164304400010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64304600005', 7020, 19, '164304600005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64304600010', 7020, 19, '164304600010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64304800005', 7020, 19, '164304800005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64304800010', 7020, 19, '164304800010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64305200005', 7020, 19, '164305200005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64305200010', 7020, 19, '164305200010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64305400005', 7020, 19, '164305400005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64305400010', 7020, 19, '164305400010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64305600005', 7020, 19, '164305600005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64305600010', 7020, 19, '164305600010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64305800005', 7020, 19, '164305800005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64305800010', 7020, 19, '164305800010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81050500015', 7020, 19, '181050500015702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81050500020', 7020, 19, '181050500020702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81050500040', 7020, 19, '181050500040702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201500010', 7020, 19, '181201500010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '83050000005', 7020, 19, '183050000005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000025', 7020, 20, '151903000025702020')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 20, '159000000005702020')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 20, '159000001005702020')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 21, '119049500005702021')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 21, '159000000005702021')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 21, '159000001005702021')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16550500005', 7020, 22, '116550500005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16551000015', 7020, 22, '116551000015702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16559500010', 7020, 22, '116559500010702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500005', 7020, 22, '116879500005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500080', 7020, 22, '16879500080702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500085', 7020, 22, '116879500085702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500090', 7020, 22, '116879500090702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500095', 7020, 22, '116879500095702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19040500005', 7020, 22, '119040500005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19042000080', 7020, 22, '119042000080702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19042000090', 7020, 22, '119042000090702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 22, '119049500005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500080', 7020, 22, '119049500080702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19201500020', 7020, 22, '119201500020702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19503000005', 7020, 22, '119503000005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19993400015', 7020, 22, '119993400015702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19993400016', 7020, 22, '119993400016702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '21651500025', 7020, 22, '21651500025702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500005', 7020, 22, '125559500005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25951000005', 7020, 22, '125951000005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25951000010', 7020, 22, '125951000010702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25951000015', 7020, 22, '125951000015702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500025', 7020, 22, '25959500025702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500005', 7020, 22, '127049500005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27101500005', 7020, 22, '127101500005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28100500005', 7020, 22, '128100500005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28101000005', 7020, 22, '128101000005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28652000005', 7020, 22, '128652000005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41020300006', 7020, 22, '141020300006702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900040', 7020, 22, '141600900040702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500005', 7020, 22, '142959500005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500010', 7020, 22, '142959500010702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51200300005', 7020, 22, '151200300005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51200500005', 7020, 22, '151200500005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51200500010', 7020, 22, '151200500010702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51200500015', 7020, 22, '151200500015702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51201000005', 7020, 22, '151201000005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51201500005', 7020, 22, '151201500005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51202500005', 7020, 22, '151202500005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51203000005', 7020, 22, '151203000005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51203500005', 7020, 22, '151203500005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51204000005', 7020, 22, '151204000005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51204500005', 7020, 22, '151204500005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51205000005', 7020, 22, '151205000005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51205500005', 7020, 22, '151205500005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207000005', 7020, 22, '151207000005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207000010', 7020, 22, '151207000010702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207000900', 7020, 22, '151207000900702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207500005', 7020, 22, '151207500005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51208000005', 7020, 22, '151208000005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51208000010', 7020, 22, '151208000010702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51208000011', 7020, 22, '151208000011702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51208500005', 7020, 22, '51208500005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209000005', 7020, 22, '151209000005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209200005', 7020, 22, '151209200005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209500005', 7020, 22, '151209500005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209500010', 7020, 22, '151209500010702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209500015', 7020, 22, '151209500015702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209500020', 7020, 22, '151209500020702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600010', 7020, 22, '51209600010702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600030', 7020, 22, '151209600030702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600035', 7020, 22, '151209600035702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600050', 7020, 22, '151209600050702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700005', 7020, 22, '151209700005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700010', 7020, 22, '151209700010702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700015', 7020, 22, '151209700015702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700020', 7020, 22, '151209700020702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700025', 7020, 22, '151209700025702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700030', 7020, 22, '151209700030702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700035', 7020, 22, '151209700035702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700040', 7020, 22, '151209700040702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700045', 7020, 22, '151209700045702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700050', 7020, 22, '151209700050702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700055', 7020, 22, '151209700055702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700060', 7020, 22, '151209700060702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700065', 7020, 22, '151209700065702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700070', 7020, 22, '151209700070702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700075', 7020, 22, '151209700075702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700080', 7020, 22, '151209700080702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700085', 7020, 22, '151209700085702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700090', 7020, 22, '151209700090702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700095', 7020, 22, '151209700095702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700100', 7020, 22, '151209700100702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700105', 7020, 22, '151209700105702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700110', 7020, 22, '151209700110702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700115', 7020, 22, '151209700115702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700120', 7020, 22, '151209700120702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700125', 7020, 22, '151209700125702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700130', 7020, 22, '151209700130702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700135', 7020, 22, '151209700135702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700140', 7020, 22, '151209700140702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500021', 7020, 22, '151309500021702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000015', 7020, 22, '151701000015702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000016', 7020, 22, '151701000016702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51704000006', 7020, 22, '151704000006702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51801500020', 7020, 22, '151801500020702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901000010', 7020, 22, '151901000010702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500010', 7020, 22, '151902500010702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500005', 7020, 22, '151903500005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500010', 7020, 22, '151903500010702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500015', 7020, 22, '151903500015702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500020', 7020, 22, '151903500020702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000005', 7020, 22, '151904000005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000010', 7020, 22, '151904000010702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500090', 7020, 22, '151909500090702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500091', 7020, 22, '151909500091702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500095', 7020, 22, '151909500095702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500096', 7020, 22, '151909500096702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500190', 7020, 22, '151909500190702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500191', 7020, 22, '151909500191702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500193', 7020, 22, '151909500193702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52309500005', 7020, 22, '152309500005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500005', 7020, 22, '152959500005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500010', 7020, 22, '152959500010702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 22, '159000000005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 22, '159000001005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500085', 7020, 23, '116879500085702023')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19042000090', 7020, 23, '119042000090702023')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500080', 7020, 23, '119049500080702023')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 23, '159000000005702023')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 23, '159000001005702023')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 24, '119049500005702024')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 24, '159000000005702024')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 24, '159000001005702024')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16550500005', 7020, 25, '116550500005702025')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19041500005', 7020, 25, '119041500005702025')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19042000080', 7020, 25, '119042000080702025')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19042000090', 7020, 25, '119042000090702025')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 25, '119049500005702025')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 25, '159000000005702025')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 25, '159000001005702025')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 27, '159000000005702027')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 27, '159000001005702027')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19042000080', 7020, 26, '119042000080702026')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500005', 7020, 26, '127049500005702026')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51801500020', 7020, 26, '151801500020702026')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 26, '159000000005702026')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 26, '159000001005702026')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500015', 7020, 28, '111150500015702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500250', 7020, 28, '111150500250702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500255', 7020, 28, '111150500255702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500260', 7020, 28, '111150500260702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500265', 7020, 28, '111150500265702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500270', 7020, 28, '111150500270702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19042000080', 7020, 28, '119042000080702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19042000090', 7020, 28, '119042000090702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 28, '119049500005702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500080', 7020, 28, '119049500080702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19209500', 7020, 28, '119209500702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25100500005', 7020, 28, '125100500005702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500005', 7020, 28, '127049500005702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27950500125', 7020, 28, '127950500125702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41152500030', 7020, 28, '141152500030702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51039500005', 7020, 28, '151039500005702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51152000010', 7020, 28, '151152000010702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51152000015', 7020, 28, '151152000015702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51152000020', 7020, 28, '151152000020702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 28, '159000000005702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 28, '159000001005702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81050500025', 7020, 28, '181050500025702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81050500030', 7020, 28, '181050500030702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '84050000005', 7020, 28, '184050000005702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 29, '119049500005702029')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51401000005', 7020, 29, '151401000005702029')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 29, '159000000005702029')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 29, '159000001005702029')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16380500010', 7020, 30, '116380500010702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16381000010', 7020, 30, '116381000010702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16381500010', 7020, 30, '116381500010702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16382000010', 7020, 30, '116382000010702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16382500010', 7020, 30, '116382500010702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16390500010', 7020, 30, '116390500010702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16391000010', 7020, 30, '116391000010702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16391500010', 7020, 30, '116391500010702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16392000010', 7020, 30, '116392000010702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16392500010', 7020, 30, '116392500010702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16871000005', 7020, 30, '116871000005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500040', 7020, 30, '116879500040702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19040500005', 7020, 30, '119040500005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19041000010', 7020, 30, '119041000010702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19042000080', 7020, 30, '119042000080702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19042000090', 7020, 30, '119042000090702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 30, '119049500005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500080', 7020, 30, '119049500080702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19901000020', 7020, 30, '119901000020702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19903500005', 7020, 30, '19903500005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25151000005', 7020, 30, '125151000005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25152000005', 7020, 30, '125152000005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25309500005', 7020, 30, '125309500005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25309500010', 7020, 30, '125309500010702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25309500020', 7020, 30, '125309500020702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000005', 7020, 30, '125350000005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500042', 7020, 30, '125550500042702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500091', 7020, 30, '125550500091702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500096', 7020, 30, '125550500096702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500100', 7020, 30, '25550500100702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500201', 7020, 30, '125550500201702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500202', 7020, 30, '125550500202702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500203', 7020, 30, '125550500203702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500205', 7020, 30, '125550500205702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500207', 7020, 30, '125550500207702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500208', 7020, 30, '125550500208702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500209', 7020, 30, '125550500209702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500210', 7020, 30, '125550500210702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500211', 7020, 30, '125550500211702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500227', 7020, 30, '125550500227702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500300', 7020, 30, '125550500300702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500301', 7020, 30, '125550500301702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500302', 7020, 30, '125550500302702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500303', 7020, 30, '125550500303702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500304', 7020, 30, '125550500304702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500305', 7020, 30, '125550500305702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500307', 7020, 30, '125550500307702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500310', 7020, 30, '125550500310702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500312', 7020, 30, '125550500312702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500313', 7020, 30, '125550500313702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500314', 7020, 30, '125550500314702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500315', 7020, 30, '125550500315702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500316', 7020, 30, '125550500316702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500317', 7020, 30, '125550500317702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500318', 7020, 30, '125550500318702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500319', 7020, 30, '125550500319702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500321', 7020, 30, '125550500321702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500390', 7020, 30, '125550500390702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500401', 7020, 30, '125550500401702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500402', 7020, 30, '125550500402702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500404', 7020, 30, '125550500404702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500420', 7020, 30, '125550500420702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500531', 7020, 30, '125550500531702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25957000030', 7020, 30, '125957000030702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500005', 7020, 30, '127049500005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28151000005', 7020, 30, '128151000005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28959500130', 7020, 30, '128959500130702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28959500131', 7020, 30, '128959500131702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41020200005', 7020, 30, '141020200005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41020900005', 7020, 30, '141020900005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41021000010', 7020, 30, '141021000010702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500005', 7020, 30, '141159500005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500005', 7020, 30, '142959500005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51039500015', 7020, 30, '151039500015702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51400500005', 7020, 30, '51400500005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51401000005', 7020, 30, '51401000005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51401500005', 7020, 30, '51401500005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51402000005', 7020, 30, '51402000005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51402500005', 7020, 30, '51402500005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51402500010', 7020, 30, '151402500010702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51402500011', 7020, 30, '151402500011702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51402500015', 7020, 30, '151402500015702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403000005', 7020, 30, '51403000005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403500005', 7020, 30, '51403500005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403500010', 7020, 30, '151403500010702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403500011', 7020, 30, '151403500011702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403500015', 7020, 30, '151403500015702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403500020', 7020, 30, '151403500020702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500005', 7020, 30, '51409500005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500010', 7020, 30, '151409500010702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500011', 7020, 30, '151409500011702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500015', 7020, 30, '151409500015702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500016', 7020, 30, '151409500016702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500020', 7020, 30, '151409500020702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500025', 7020, 30, '151409500025702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500026', 7020, 30, '151409500026702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51509500010', 7020, 30, '151509500010702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51509500011', 7020, 30, '151509500011702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904500005', 7020, 30, '151904500005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904500551', 7020, 30, '151904500551702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500551', 7020, 30, '151909500551702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52301000005', 7020, 30, '152301000005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500010', 7020, 30, '152959500010702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 30, '159000000005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 30, '159000001005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11050500005', 7020, 31, '11050500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11050500050', 7020, 31, '11050500050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11050500100', 7020, 31, '11050500100702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11051000005', 7020, 31, '11051000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11100500005', 7020, 31, '11100500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11100500010', 7020, 31, '111100500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500015', 7020, 31, '111150500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500050', 7020, 31, '111150500050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500055', 7020, 31, '111150500055702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500060', 7020, 31, '111150500060702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500065', 7020, 31, '111150500065702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500070', 7020, 31, '111150500070702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500075', 7020, 31, '111150500075702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500080', 7020, 31, '111150500080702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500085', 7020, 31, '111150500085702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500090', 7020, 31, '111150500090702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500100', 7020, 31, '111150500100702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500105', 7020, 31, '111150500105702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500115', 7020, 31, '111150500115702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500120', 7020, 31, '111150500120702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500125', 7020, 31, '111150500125702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500130', 7020, 31, '111150500130702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500135', 7020, 31, '111150500135702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500140', 7020, 31, '111150500140702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500145', 7020, 31, '111150500145702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500160', 7020, 31, '111150500160702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500165', 7020, 31, '111150500165702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500170', 7020, 31, '111150500170702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500175', 7020, 31, '111150500175702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500180', 7020, 31, '111150500180702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500185', 7020, 31, '111150500185702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500190', 7020, 31, '111150500190702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500195', 7020, 31, '111150500195702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500200', 7020, 31, '111150500200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500205', 7020, 31, '111150500205702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500235', 7020, 31, '111150500235702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500240', 7020, 31, '111150500240702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500245', 7020, 31, '111150500245702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500250', 7020, 31, '111150500250702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500255', 7020, 31, '111150500255702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500260', 7020, 31, '111150500260702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500265', 7020, 31, '111150500265702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500270', 7020, 31, '111150500270702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11200000005', 7020, 31, '11200000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11300500005', 7020, 31, '11300500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14560500005', 7020, 31, '14560500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14561000005', 7020, 31, '14561000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14561500005', 7020, 31, '14561500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14562000005', 7020, 31, '14562000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14562500005', 7020, 31, '14562500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14570500005', 7020, 31, '14570500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14571000005', 7020, 31, '14571000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14571500005', 7020, 31, '14571500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14572000005', 7020, 31, '14572000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14572500005', 7020, 31, '14572500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14598200005', 7020, 31, '14598200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14608200005', 7020, 31, '14608200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14628200005', 7020, 31, '14628200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14638200005', 7020, 31, '14638200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14658200005', 7020, 31, '14658200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14668200005', 7020, 31, '14668200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14678200005', 7020, 31, '14678200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14688200005', 7020, 31, '14688200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14698200005', 7020, 31, '14698200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14708200005', 7020, 31, '14708200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14871500005', 7020, 31, '114871500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14871500007', 7020, 31, '114871500007702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14871500010', 7020, 31, '114871500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14871500012', 7020, 31, '114871500012702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14871500015', 7020, 31, '114871500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14871500017', 7020, 31, '114871500017702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14871500020', 7020, 31, '114871500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14871500022', 7020, 31, '114871500022702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14871500025', 7020, 31, '114871500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14871500027', 7020, 31, '114871500027702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14930500005', 7020, 31, '14930500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14930700005', 7020, 31, '14930700005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14931000005', 7020, 31, '14931000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14931200005', 7020, 31, '14931200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14931500005', 7020, 31, '14931500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14931700005', 7020, 31, '14931700005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14932000005', 7020, 31, '14932000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14932200005', 7020, 31, '114932200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14932500005', 7020, 31, '14932500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14932700005', 7020, 31, '14932700005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14939000005', 7020, 31, '14939000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14950500005', 7020, 31, '14950500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14950500020', 7020, 31, '114950500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14950700005', 7020, 31, '14950700005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14950700020', 7020, 31, '114950700020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14951000005', 7020, 31, '14951000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14951000020', 7020, 31, '114951000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14951200005', 7020, 31, '14951200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14951200020', 7020, 31, '114951200020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14951500005', 7020, 31, '14951500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14951500020', 7020, 31, '114951500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14951700005', 7020, 31, '14951700005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14951700020', 7020, 31, '114951700020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14952000005', 7020, 31, '14952000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14952000020', 7020, 31, '114952000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14952200005', 7020, 31, '14952200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14952200020', 7020, 31, '114952200020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14952500005', 7020, 31, '14952500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14952500020', 7020, 31, '114952500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14952700005', 7020, 31, '14952700005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14952700020', 7020, 31, '114952700020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14959000005', 7020, 31, '14959000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14980500005', 7020, 31, '114980500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14980500010', 7020, 31, '114980500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16053200005', 7020, 31, '16053200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16053200010', 7020, 31, '16053200010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16053400005', 7020, 31, '16053400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16053400010', 7020, 31, '16053400010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16053600005', 7020, 31, '16053600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16053600010', 7020, 31, '16053600010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16053800005', 7020, 31, '16053800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16053800010', 7020, 31, '16053800010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16054000005', 7020, 31, '16054000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16054000010', 7020, 31, '16054000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16054200005', 7020, 31, '16054200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16054200010', 7020, 31, '16054200010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16054400005', 7020, 31, '16054400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16054400010', 7020, 31, '16054400010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16054600005', 7020, 31, '16054600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16054600010', 7020, 31, '16054600010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16054800005', 7020, 31, '16054800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16054800010', 7020, 31, '16054800010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16054900005', 7020, 31, '16054900005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16054900010', 7020, 31, '16054900010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16102500005', 7020, 31, '116102500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16109500005', 7020, 31, '16109500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16109500040', 7020, 31, '116109500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16109500045', 7020, 31, '116109500045702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16109500050', 7020, 31, '116109500050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16380500010', 7020, 31, '16380500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16380500105', 7020, 31, '16380500105702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16380500110', 7020, 31, '16380500110702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16380500115', 7020, 31, '16380500115702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16380500200', 7020, 31, '16380500200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16380500205', 7020, 31, '116380500205702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16380500900', 7020, 31, '16380500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16380500901', 7020, 31, '116380500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16381000010', 7020, 31, '16381000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16381000105', 7020, 31, '16381000105702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16381000110', 7020, 31, '16381000110702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16381000115', 7020, 31, '16381000115702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16381000200', 7020, 31, '16381000200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16381000205', 7020, 31, '116381000205702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16381000900', 7020, 31, '16381000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16381000901', 7020, 31, '116381000901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16381500010', 7020, 31, '16381500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16381500105', 7020, 31, '16381500105702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16381500110', 7020, 31, '16381500110702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16381500115', 7020, 31, '16381500115702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16381500200', 7020, 31, '16381500200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16381500205', 7020, 31, '116381500205702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16381500900', 7020, 31, '16381500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500800', 7020, 31, '116879500800702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500850', 7020, 31, '116879500850702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500900', 7020, 31, '16879500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500930', 7020, 31, '116879500930702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500950', 7020, 31, '16879500950702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500960', 7020, 31, '116879500960702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500970', 7020, 31, '116879500970702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500980', 7020, 31, '116879500980702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500990', 7020, 31, '16879500990702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500998', 7020, 31, '116879500998702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500999', 7020, 31, '16879500999702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16920500005', 7020, 31, '16920500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16920500010', 7020, 31, '16920500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16921000005', 7020, 31, '16921000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16921000010', 7020, 31, '16921000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16921500005', 7020, 31, '16921500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16921500010', 7020, 31, '16921500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16922000005', 7020, 31, '16922000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16922000010', 7020, 31, '16922000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16922500005', 7020, 31, '16922500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16922500010', 7020, 31, '16922500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16923000005', 7020, 31, '16923000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16923000010', 7020, 31, '16923000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16923000100', 7020, 31, '16923000100702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16923000200', 7020, 31, '16923000200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16923000900', 7020, 31, '16923000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16923500005', 7020, 31, '16923500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16923500010', 7020, 31, '16923500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16923500100', 7020, 31, '16923500100702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16923500200', 7020, 31, '16923500200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16923500900', 7020, 31, '16923500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16924000005', 7020, 31, '16924000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16924000010', 7020, 31, '16924000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16924000100', 7020, 31, '16924000100702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16924000200', 7020, 31, '16924000200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16924000900', 7020, 31, '16924000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16924500005', 7020, 31, '16924500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16924500010', 7020, 31, '16924500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16924500100', 7020, 31, '16924500100702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16924500200', 7020, 31, '16924500200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16924500900', 7020, 31, '16924500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16925000005', 7020, 31, '16925000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16925000010', 7020, 31, '16925000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16925000100', 7020, 31, '16925000100702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16925000200', 7020, 31, '16925000200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16925000900', 7020, 31, '16925000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16941000010', 7020, 31, '116941000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16945200005', 7020, 31, '16945200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16945200010', 7020, 31, '16945200010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16945200020', 7020, 31, '116945200020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16945300005', 7020, 31, '16945300005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16945300010', 7020, 31, '16945300010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16945300020', 7020, 31, '116945300020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16945400005', 7020, 31, '16945400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16945400010', 7020, 31, '16945400010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16945400020', 7020, 31, '116945400020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16945600005', 7020, 31, '16945600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16945600010', 7020, 31, '16945600010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16945600020', 7020, 31, '116945600020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16945700005', 7020, 31, '16945700005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16945700010', 7020, 31, '16945700010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16945700020', 7020, 31, '116945700020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946200005', 7020, 31, '16946200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946200010', 7020, 31, '16946200010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946200020', 7020, 31, '116946200020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946200100', 7020, 31, '16946200100702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946200200', 7020, 31, '16946200200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946200900', 7020, 31, '16946200900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946300005', 7020, 31, '16946300005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946300010', 7020, 31, '16946300010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946300020', 7020, 31, '116946300020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946300100', 7020, 31, '16946300100702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946300200', 7020, 31, '16946300200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946300900', 7020, 31, '16946300900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946400005', 7020, 31, '16946400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946400010', 7020, 31, '16946400010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946400020', 7020, 31, '116946400020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946400100', 7020, 31, '16946400100702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946400200', 7020, 31, '16946400200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946400900', 7020, 31, '16946400900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946600005', 7020, 31, '16946600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946600010', 7020, 31, '16946600010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946600020', 7020, 31, '116946600020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946600100', 7020, 31, '16946600100702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946600200', 7020, 31, '16946600200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946600900', 7020, 31, '16946600900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946700005', 7020, 31, '16946700005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946700010', 7020, 31, '16946700010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946700020', 7020, 31, '116946700020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946700100', 7020, 31, '16946700100702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946700200', 7020, 31, '16946700200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16946700900', 7020, 31, '16946700900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16947400005', 7020, 31, '16947400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16947400010', 7020, 31, '16947400010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16947400100', 7020, 31, '16947400100702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16947400200', 7020, 31, '16947400200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16947400900', 7020, 31, '16947400900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16985500005', 7020, 31, '116985500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16985500010', 7020, 31, '116985500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16991500005', 7020, 31, '116991500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16991500052', 7020, 31, '116991500052702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16991500053', 7020, 31, '116991500053702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16991500054', 7020, 31, '116991500054702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16991500056', 7020, 31, '116991500056702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16991500057', 7020, 31, '116991500057702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16991500062', 7020, 31, '116991500062702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16991500063', 7020, 31, '116991500063702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16991500064', 7020, 31, '116991500064702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16991500066', 7020, 31, '116991500066702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16991500067', 7020, 31, '116991500067702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '18951000005', 7020, 31, '18951000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '18951500005', 7020, 31, '18951500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19040500005', 7020, 31, '19040500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19041000005', 7020, 31, '19041000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19041000010', 7020, 31, '19041000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19041500005', 7020, 31, '119041500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19042000080', 7020, 31, '119042000080702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19042000090', 7020, 31, '119042000090702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 31, '119049500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500080', 7020, 31, '119049500080702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19201500020', 7020, 31, '119201500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500200', 7020, 31, '119909500200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500600', 7020, 31, '119909500600702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500603', 7020, 31, '119909500603702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500604', 7020, 31, '119909500604702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500605', 7020, 31, '119909500605702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500777', 7020, 31, '119909500777702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500778', 7020, 31, '119909500778702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500805', 7020, 31, '119909500805702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500810', 7020, 31, '119909500810702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500815', 7020, 31, '119909500815702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500820', 7020, 31, '119909500820702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500825', 7020, 31, '119909500825702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500826', 7020, 31, '119909500826702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500830', 7020, 31, '119909500830702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500850', 7020, 31, '119909500850702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500855', 7020, 31, '119909500855702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500930', 7020, 31, '119909500930702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500950', 7020, 31, '119909500950702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500960', 7020, 31, '119909500960702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500997', 7020, 31, '119909500997702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '21150500005', 7020, 31, '121150500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '21151500005', 7020, 31, '121151500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '21152500005', 7020, 31, '121152500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '21153000005', 7020, 31, '121153000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '21651500005', 7020, 31, '121651500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '21651500010', 7020, 31, '21651500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '21651500030', 7020, 31, '121651500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '24101000005', 7020, 31, '124101000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25050500011', 7020, 31, '125050500011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25050500015', 7020, 31, '125050500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25050500020', 7020, 31, '125050500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25050500025', 7020, 31, '125050500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25050500050', 7020, 31, '125050500050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25051500005', 7020, 31, '125051500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25051500010', 7020, 31, '125051500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25101000005', 7020, 31, '125101000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25151000005', 7020, 31, '125151000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25302000005', 7020, 31, '125302000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25309500010', 7020, 31, '125309500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000005', 7020, 31, '25350000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000035', 7020, 31, '125350000035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25450000005', 7020, 31, '125450000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25450000010', 7020, 31, '125450000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500091', 7020, 31, '125550500091702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500390', 7020, 31, '125550500390702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25951000005', 7020, 31, '125951000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25951000010', 7020, 31, '125951000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25951000015', 7020, 31, '125951000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25957000005', 7020, 31, '25957000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25957000006', 7020, 31, '125957000006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25957000010', 7020, 31, '25957000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25957000015', 7020, 31, '25957000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25957000020', 7020, 31, '25957000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25957000025', 7020, 31, '25957000025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25957000030', 7020, 31, '25957000030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25957000035', 7020, 31, '25957000035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25957000040', 7020, 31, '125957000040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25957000045', 7020, 31, '125957000045702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500005', 7020, 31, '25959500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500010', 7020, 31, '25959500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500015', 7020, 31, '125959500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500030', 7020, 31, '125959500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500035', 7020, 31, '125959500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500040', 7020, 31, '125959500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500044', 7020, 31, '125959500044702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500045', 7020, 31, '125959500045702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500050', 7020, 31, '125959500050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500055', 7020, 31, '125959500055702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500056', 7020, 31, '125959500056702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500060', 7020, 31, '125959500060702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500700', 7020, 31, '125959500700702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500800', 7020, 31, '25959500800702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500810', 7020, 31, '125959500810702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500900', 7020, 31, '25959500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500950', 7020, 31, '25959500950702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27041100005', 7020, 31, '127041100005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27041600005', 7020, 31, '127041600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27042100005', 7020, 31, '127042100005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27044000005', 7020, 31, '27044000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27044000010', 7020, 31, '27044000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27044000015', 7020, 31, '127044000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500005', 7020, 31, '27049500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500010', 7020, 31, '27049500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500015', 7020, 31, '127049500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27150500005', 7020, 31, '127150500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27151000005', 7020, 31, '27151000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27203500005', 7020, 31, '27203500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27950500005', 7020, 31, '127950500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27950500010', 7020, 31, '127950500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27950500015', 7020, 31, '127950500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27950500016', 7020, 31, '127950500016702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27950500120', 7020, 31, '127950500120702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27950500125', 7020, 31, '127950500125702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27951000005', 7020, 31, '27951000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27951500005', 7020, 31, '127951500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27951500015', 7020, 31, '127951500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27959500950', 7020, 31, '127959500950702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27959500998', 7020, 31, '127959500998702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41020200005', 7020, 31, '41020200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41020400', 7020, 31, '141020400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41020400005', 7020, 31, '141020400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41020900005', 7020, 31, '41020900005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41021000005', 7020, 31, '41021000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41021000010', 7020, 31, '41021000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41021000030', 7020, 31, '141021000030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41040200010', 7020, 31, '141040200010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41152500005', 7020, 31, '41152500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41152500010', 7020, 31, '41152500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41152500015', 7020, 31, '141152500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41152500020', 7020, 31, '141152500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41152500030', 7020, 31, '141152500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41152500035', 7020, 31, '141152500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41152500040', 7020, 31, '141152500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41152500045', 7020, 31, '141152500045702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500005', 7020, 31, '41159500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500010', 7020, 31, '141159500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500011', 7020, 31, '141159500011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500015', 7020, 31, '141159500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500016', 7020, 31, '141159500016702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500020', 7020, 31, '141159500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500025', 7020, 31, '141159500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500030', 7020, 31, '141159500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500035', 7020, 31, '141159500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500040', 7020, 31, '141159500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500045', 7020, 31, '141159500045702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500050', 7020, 31, '141159500050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800005', 7020, 31, '41600800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800010', 7020, 31, '41600800010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800015', 7020, 31, '41600800015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800020', 7020, 31, '141600800020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800025', 7020, 31, '141600800025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800030', 7020, 31, '141600800030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800040', 7020, 31, '141600800040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800120', 7020, 31, '141600800120702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800170', 7020, 31, '141600800170702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800175', 7020, 31, '141600800175702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800212', 7020, 31, '141600800212702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800213', 7020, 31, '141600800213702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800216', 7020, 31, '141600800216702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800217', 7020, 31, '141600800217702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800222', 7020, 31, '141600800222702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800223', 7020, 31, '141600800223702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800226', 7020, 31, '141600800226702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800227', 7020, 31, '141600800227702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800232', 7020, 31, '141600800232702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800233', 7020, 31, '141600800233702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800236', 7020, 31, '141600800236702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800237', 7020, 31, '141600800237702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800242', 7020, 31, '141600800242702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800243', 7020, 31, '141600800243702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800246', 7020, 31, '141600800246702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800247', 7020, 31, '141600800247702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800252', 7020, 31, '141600800252702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800253', 7020, 31, '141600800253702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800256', 7020, 31, '141600800256702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800257', 7020, 31, '141600800257702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800512', 7020, 31, '141600800512702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800513', 7020, 31, '141600800513702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800516', 7020, 31, '141600800516702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800517', 7020, 31, '141600800517702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800522', 7020, 31, '141600800522702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800523', 7020, 31, '141600800523702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800526', 7020, 31, '141600800526702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800527', 7020, 31, '141600800527702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800532', 7020, 31, '141600800532702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800533', 7020, 31, '141600800533702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800536', 7020, 31, '141600800536702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800537', 7020, 31, '141600800537702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800542', 7020, 31, '141600800542702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800543', 7020, 31, '141600800543702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800546', 7020, 31, '141600800546702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800547', 7020, 31, '141600800547702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800552', 7020, 31, '141600800552702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800553', 7020, 31, '141600800553702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800556', 7020, 31, '141600800556702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800557', 7020, 31, '141600800557702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900005', 7020, 31, '41600900005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900010', 7020, 31, '41600900010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900015', 7020, 31, '141600900015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900020', 7020, 31, '141600900020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900030', 7020, 31, '141600900030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900035', 7020, 31, '141600900035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900211', 7020, 31, '141600900211702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900215', 7020, 31, '141600900215702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900221', 7020, 31, '141600900221702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900225', 7020, 31, '141600900225702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900231', 7020, 31, '141600900231702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900235', 7020, 31, '141600900235702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900241', 7020, 31, '141600900241702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900245', 7020, 31, '141600900245702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900251', 7020, 31, '141600900251702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900255', 7020, 31, '141600900255702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900511', 7020, 31, '141600900511702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900515', 7020, 31, '141600900515702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900521', 7020, 31, '141600900521702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900525', 7020, 31, '141600900525702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900531', 7020, 31, '141600900531702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900535', 7020, 31, '141600900535702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900541', 7020, 31, '141600900541702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900545', 7020, 31, '141600900545702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900551', 7020, 31, '141600900551702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900555', 7020, 31, '141600900555702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41604500005', 7020, 31, '141604500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000005', 7020, 31, '141606000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000010', 7020, 31, '141606000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000215', 7020, 31, '141606000215702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000216', 7020, 31, '141606000216702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000217', 7020, 31, '141606000217702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000225', 7020, 31, '141606000225702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000226', 7020, 31, '141606000226702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000227', 7020, 31, '141606000227702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000235', 7020, 31, '141606000235702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000236', 7020, 31, '141606000236702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000237', 7020, 31, '141606000237702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000245', 7020, 31, '141606000245702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000246', 7020, 31, '141606000246702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000247', 7020, 31, '141606000247702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000255', 7020, 31, '141606000255702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000256', 7020, 31, '141606000256702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000257', 7020, 31, '141606000257702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000515', 7020, 31, '141606000515702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000516', 7020, 31, '141606000516702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000517', 7020, 31, '141606000517702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000525', 7020, 31, '141606000525702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000526', 7020, 31, '141606000526702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000527', 7020, 31, '141606000527702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000535', 7020, 31, '141606000535702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000536', 7020, 31, '141606000536702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000537', 7020, 31, '141606000537702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000545', 7020, 31, '141606000545702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000546', 7020, 31, '141606000546702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000547', 7020, 31, '141606000547702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000555', 7020, 31, '141606000555702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000556', 7020, 31, '141606000556702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000557', 7020, 31, '141606000557702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41959500005', 7020, 31, '41959500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41959500010', 7020, 31, '41959500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41959500095', 7020, 31, '141959500095702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42250500005', 7020, 31, '42250500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42250500010', 7020, 31, '42250500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42250500015', 7020, 31, '42250500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42250500020', 7020, 31, '42250500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42250500025', 7020, 31, '42250500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42250500030', 7020, 31, '42250500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42250500035', 7020, 31, '42250500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42250500040', 7020, 31, '142250500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42251300006', 7020, 31, '142251300006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500005', 7020, 31, '42259500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500010', 7020, 31, '42259500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500011', 7020, 31, '142259500011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500015', 7020, 31, '142259500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500100', 7020, 31, '142259500100702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500005', 7020, 31, '142959500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500010', 7020, 31, '142959500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500020', 7020, 31, '142959500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500205', 7020, 31, '142959500205702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '43050000005', 7020, 31, '143050000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '43050000010', 7020, 31, '143050000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '43050000015', 7020, 31, '143050000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '43050000020', 7020, 31, '143050000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51020500005', 7020, 31, '151020500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51020600005', 7020, 31, '151020600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51020700005', 7020, 31, '151020700005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51152000005', 7020, 31, '151152000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51154300005', 7020, 31, '51154300005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51156500005', 7020, 31, '51156500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51158000005', 7020, 31, '51158000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500010', 7020, 31, '151159500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500015', 7020, 31, '151159500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51200300005', 7020, 31, '51200300005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51200500005', 7020, 31, '51200500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51200500010', 7020, 31, '51200500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51200500015', 7020, 31, '151200500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51201000005', 7020, 31, '51201000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51201500005', 7020, 31, '51201500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51202000005', 7020, 31, '51202000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51202500005', 7020, 31, '51202500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51203000005', 7020, 31, '51203000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51203500005', 7020, 31, '51203500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51204000005', 7020, 31, '51204000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51204500005', 7020, 31, '51204500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51205000005', 7020, 31, '51205000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51205500005', 7020, 31, '51205500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51206000005', 7020, 31, '51206000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51206500005', 7020, 31, '51206500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207000005', 7020, 31, '51207000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207000010', 7020, 31, '51207000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207500005', 7020, 31, '51207500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51208000005', 7020, 31, '51208000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209000005', 7020, 31, '51209000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209200005', 7020, 31, '51209200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209500005', 7020, 31, '51209500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209500010', 7020, 31, '51209500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209500015', 7020, 31, '51209500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600005', 7020, 31, '51209600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600010', 7020, 31, '51209600010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600015', 7020, 31, '51209600015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600020', 7020, 31, '51209600020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600025', 7020, 31, '51209600025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600050', 7020, 31, '51209600050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700005', 7020, 31, '151209700005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700015', 7020, 31, '151209700015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700040', 7020, 31, '151209700040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700045', 7020, 31, '151209700045702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700050', 7020, 31, '151209700050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700060', 7020, 31, '151209700060702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700075', 7020, 31, '151209700075702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700095', 7020, 31, '151209700095702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700105', 7020, 31, '151209700105702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700110', 7020, 31, '151209700110702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700115', 7020, 31, '151209700115702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51270500005', 7020, 31, '51270500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51279700005', 7020, 31, '51279700005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500030', 7020, 31, '151309500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51402500015', 7020, 31, '151402500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403500005', 7020, 31, '151403500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403500010', 7020, 31, '151403500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51700300006', 7020, 31, '151700300006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000005', 7020, 31, '51701000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000010', 7020, 31, '51701000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000020', 7020, 31, '151701000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000030', 7020, 31, '151701000030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000035', 7020, 31, '151701000035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000105', 7020, 31, '51701000105702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000110', 7020, 31, '151701000110702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000170', 7020, 31, '151701000170702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000211', 7020, 31, '151701000211702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000215', 7020, 31, '151701000215702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000221', 7020, 31, '151701000221702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000225', 7020, 31, '151701000225702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000231', 7020, 31, '151701000231702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000235', 7020, 31, '151701000235702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000241', 7020, 31, '151701000241702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000245', 7020, 31, '151701000245702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000251', 7020, 31, '151701000251702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000255', 7020, 31, '151701000255702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000511', 7020, 31, '151701000511702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000515', 7020, 31, '151701000515702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000521', 7020, 31, '151701000521702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000525', 7020, 31, '151701000525702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000531', 7020, 31, '151701000531702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000535', 7020, 31, '151701000535702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000541', 7020, 31, '151701000541702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000545', 7020, 31, '151701000545702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000551', 7020, 31, '151701000551702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000555', 7020, 31, '151701000555702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500005', 7020, 31, '51701500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500010', 7020, 31, '51701500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500020', 7020, 31, '151701500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500025', 7020, 31, '151701500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500030', 7020, 31, '151701500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500040', 7020, 31, '151701500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500105', 7020, 31, '51701500105702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500110', 7020, 31, '51701500110702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500120', 7020, 31, '51701500120702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500130', 7020, 31, '51701500130702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500170', 7020, 31, '151701500170702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500175', 7020, 31, '151701500175702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500212', 7020, 31, '151701500212702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500213', 7020, 31, '151701500213702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500216', 7020, 31, '151701500216702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500217', 7020, 31, '151701500217702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500222', 7020, 31, '151701500222702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500223', 7020, 31, '151701500223702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500226', 7020, 31, '151701500226702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500227', 7020, 31, '151701500227702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500232', 7020, 31, '151701500232702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500233', 7020, 31, '151701500233702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500236', 7020, 31, '151701500236702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500237', 7020, 31, '151701500237702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500242', 7020, 31, '151701500242702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500243', 7020, 31, '151701500243702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500246', 7020, 31, '151701500246702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500247', 7020, 31, '151701500247702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500252', 7020, 31, '151701500252702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500253', 7020, 31, '151701500253702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500256', 7020, 31, '151701500256702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500257', 7020, 31, '151701500257702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500512', 7020, 31, '151701500512702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500513', 7020, 31, '151701500513702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500516', 7020, 31, '151701500516702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500517', 7020, 31, '151701500517702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500522', 7020, 31, '151701500522702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500523', 7020, 31, '151701500523702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500526', 7020, 31, '151701500526702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500527', 7020, 31, '151701500527702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500532', 7020, 31, '151701500532702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500533', 7020, 31, '151701500533702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500536', 7020, 31, '151701500536702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500537', 7020, 31, '151701500537702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500542', 7020, 31, '151701500542702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500543', 7020, 31, '151701500543702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500546', 7020, 31, '151701500546702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500547', 7020, 31, '151701500547702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500552', 7020, 31, '151701500552702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500553', 7020, 31, '151701500553702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500556', 7020, 31, '151701500556702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500557', 7020, 31, '151701500557702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500795', 7020, 31, '151701500795702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500005', 7020, 31, '51709500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500010', 7020, 31, '151709500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500015', 7020, 31, '151709500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500020', 7020, 31, '151709500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500025', 7020, 31, '151709500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500030', 7020, 31, '151709500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500035', 7020, 31, '151709500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500040', 7020, 31, '151709500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500045', 7020, 31, '151709500045702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500050', 7020, 31, '151709500050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500055', 7020, 31, '151709500055702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500060', 7020, 31, '151709500060702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500065', 7020, 31, '151709500065702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500070', 7020, 31, '151709500070702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500075', 7020, 31, '151709500075702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500080', 7020, 31, '151709500080702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500085', 7020, 31, '151709500085702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500090', 7020, 31, '151709500090702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500095', 7020, 31, '151709500095702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500100', 7020, 31, '151709500100702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500105', 7020, 31, '151709500105702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500110', 7020, 31, '151709500110702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500115', 7020, 31, '151709500115702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500120', 7020, 31, '151709500120702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500005', 7020, 31, '151711500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500215', 7020, 31, '151711500215702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500216', 7020, 31, '151711500216702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500217', 7020, 31, '151711500217702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500225', 7020, 31, '151711500225702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500226', 7020, 31, '151711500226702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500227', 7020, 31, '151711500227702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500235', 7020, 31, '151711500235702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500236', 7020, 31, '151711500236702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500237', 7020, 31, '151711500237702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500245', 7020, 31, '151711500245702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500246', 7020, 31, '151711500246702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500247', 7020, 31, '151711500247702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500255', 7020, 31, '151711500255702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500256', 7020, 31, '151711500256702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500257', 7020, 31, '151711500257702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500515', 7020, 31, '151711500515702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500516', 7020, 31, '151711500516702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500517', 7020, 31, '151711500517702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500525', 7020, 31, '151711500525702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500526', 7020, 31, '151711500526702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500527', 7020, 31, '151711500527702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500535', 7020, 31, '151711500535702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500536', 7020, 31, '151711500536702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500537', 7020, 31, '151711500537702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500545', 7020, 31, '151711500545702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500546', 7020, 31, '151711500546702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500547', 7020, 31, '151711500547702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500555', 7020, 31, '151711500555702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500556', 7020, 31, '151711500556702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711500557', 7020, 31, '151711500557702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51713000005', 7020, 31, '151713000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51713000010', 7020, 31, '151713000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51751500005', 7020, 31, '51751500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51801500020', 7020, 31, '151801500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500005', 7020, 31, '51903500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500010', 7020, 31, '51903500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500015', 7020, 31, '51903500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500020', 7020, 31, '51903500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000005', 7020, 31, '51904000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000010', 7020, 31, '51904000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904500005', 7020, 31, '51904500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500010', 7020, 31, '51909500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500075', 7020, 31, '151909500075702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500100', 7020, 31, '151909500100702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500192', 7020, 31, '151909500192702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909700100', 7020, 31, '151909700100702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52102000005', 7020, 31, '52102000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52173500005', 7020, 31, '52173500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52174500005', 7020, 31, '52174500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52301000010', 7020, 31, '152301000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52951500005', 7020, 31, '52951500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52951500010', 7020, 31, '152951500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500005', 7020, 31, '52959500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500010', 7020, 31, '152959500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959700010', 7020, 31, '152959700010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000005', 7020, 31, '153050000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000010', 7020, 31, '153050000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000015', 7020, 31, '153050000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000020', 7020, 31, '153050000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000025', 7020, 31, '153050000025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 31, '159000000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 31, '159000001005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '61200500010', 7020, 31, '161200500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '61250500005', 7020, 31, '161250500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '61250500010', 7020, 31, '161250500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '61959500005', 7020, 31, '161959500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '62200000005', 7020, 31, '62200000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '62200000010', 7020, 31, '162200000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '62250500005', 7020, 31, '162250500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '62250500010', 7020, 31, '162250500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '62959500005', 7020, 31, '162959500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '63050000005', 7020, 31, '63050000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '63300500005', 7020, 31, '63300500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '63300500010', 7020, 31, '63300500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '63301900005', 7020, 31, '63301900005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '63301900010', 7020, 31, '63301900010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64304000005', 7020, 31, '64304000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64304000010', 7020, 31, '64304000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64304200005', 7020, 31, '64304200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64304200010', 7020, 31, '64304200010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64304400005', 7020, 31, '64304400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64304400010', 7020, 31, '64304400010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64304600005', 7020, 31, '64304600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64304600010', 7020, 31, '64304600010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64304800005', 7020, 31, '64304800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64304800010', 7020, 31, '64304800010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64305000005', 7020, 31, '64305000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64305000010', 7020, 31, '64305000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64305200005', 7020, 31, '64305200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64305200010', 7020, 31, '64305200010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64305400005', 7020, 31, '64305400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64305400010', 7020, 31, '64305400010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64305600005', 7020, 31, '64305600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64305600010', 7020, 31, '64305600010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64305800005', 7020, 31, '64305800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64305800010', 7020, 31, '64305800010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64959500010', 7020, 31, '164959500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64959500020', 7020, 31, '64959500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64959500025', 7020, 31, '64959500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64959500030', 7020, 31, '64959500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64959500035', 7020, 31, '64959500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64959500040', 7020, 31, '64959500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81050500015', 7020, 31, '181050500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81050500020', 7020, 31, '181050500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81050500040', 7020, 31, '181050500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201000005', 7020, 31, '81201000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201000010', 7020, 31, '81201000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201500005', 7020, 31, '81201500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201500010', 7020, 31, '81201500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201500015', 7020, 31, '181201500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201500020', 7020, 31, '81201500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201500025', 7020, 31, '81201500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201500030', 7020, 31, '81201500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201500035', 7020, 31, '81201500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201500040', 7020, 31, '81201500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201500095', 7020, 31, '181201500095702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81310500005', 7020, 31, '81310500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81959500005', 7020, 31, '181959500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81959500010', 7020, 31, '181959500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81959500015', 7020, 31, '181959500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81959500035', 7020, 31, '81959500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81959500040', 7020, 31, '81959500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81959500999', 7020, 31, '81959500999702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82050500', 7020, 31, '182050500702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82050500005', 7020, 31, '182050500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82050500010', 7020, 31, '182050500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82110500005', 7020, 31, '82110500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82110501005', 7020, 31, '182110501005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82111000005', 7020, 31, '182111000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82111001005', 7020, 31, '182111001005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82111500005', 7020, 31, '182111500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82111501005', 7020, 31, '182111501005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82112000005', 7020, 31, '82112000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82112001005', 7020, 31, '182112001005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82120500005', 7020, 31, '82120500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82120501005', 7020, 31, '182120501005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82121000005', 7020, 31, '182121000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82121001005', 7020, 31, '182121001005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82121500005', 7020, 31, '182121500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82121501005', 7020, 31, '182121501005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82122000005', 7020, 31, '82122000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82122001005', 7020, 31, '182122001005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82130500005', 7020, 31, '82130500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82130500010', 7020, 31, '182130500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82130501005', 7020, 31, '182130501005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82131000005', 7020, 31, '182131000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82131001005', 7020, 31, '182131001005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82132000005', 7020, 31, '82132000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82132000010', 7020, 31, '182132000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82132001005', 7020, 31, '182132001005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82140500005', 7020, 31, '82140500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82140501005', 7020, 31, '182140501005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82141000005', 7020, 31, '182141000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82141001005', 7020, 31, '182141001005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82142000005', 7020, 31, '82142000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82142001005', 7020, 31, '182142001005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82850200005', 7020, 31, '182850200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82850400005', 7020, 31, '182850400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82850600005', 7020, 31, '182850600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82850800005', 7020, 31, '182850800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82851000005', 7020, 31, '182851000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82851200005', 7020, 31, '182851200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82851400005', 7020, 31, '182851400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82851600005', 7020, 31, '182851600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82851800005', 7020, 31, '182851800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82852000005', 7020, 31, '182852000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82852200005', 7020, 31, '182852200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82852400005', 7020, 31, '182852400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82852600005', 7020, 31, '182852600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82852800005', 7020, 31, '182852800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82853000005', 7020, 31, '182853000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82860200005', 7020, 31, '182860200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82860400005', 7020, 31, '182860400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82860600005', 7020, 31, '182860600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82860800005', 7020, 31, '182860800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82861000005', 7020, 31, '182861000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82861200005', 7020, 31, '182861200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82861400005', 7020, 31, '182861400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82861600005', 7020, 31, '182861600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82861800005', 7020, 31, '182861800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82862000005', 7020, 31, '182862000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82862000008', 7020, 31, '182862000008702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82862200005', 7020, 31, '182862200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82862400005', 7020, 31, '182862400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82862600005', 7020, 31, '182862600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82862800005', 7020, 31, '182862800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19042000080', 7020, 34, '119042000080702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19042000090', 7020, 34, '119042000090702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 34, '19049500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500080', 7020, 34, '119049500080702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000005', 7020, 34, '19151000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000010', 7020, 34, '19151000010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000015', 7020, 34, '19151000015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000020', 7020, 34, '19151000020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000025', 7020, 34, '19151000025702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000030', 7020, 34, '19151000030702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000035', 7020, 34, '19151000035702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000040', 7020, 34, '19151000040702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000045', 7020, 34, '19151000045702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000050', 7020, 34, '19151000050702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000055', 7020, 34, '119151000055702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000060', 7020, 34, '119151000060702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000065', 7020, 34, '119151000065702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000095', 7020, 34, '19151000095702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151500005', 7020, 34, '19151500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151500010', 7020, 34, '19151500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151500020', 7020, 34, '19151500020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151500035', 7020, 34, '19151500035702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19153500005', 7020, 34, '119153500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19153500006', 7020, 34, '119153500006702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19159500010', 7020, 34, '119159500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19159500028', 7020, 34, '119159500028702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19200500005', 7020, 34, '19200500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19201000005', 7020, 34, '119201000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19201000010', 7020, 34, '119201000010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19201500005', 7020, 34, '119201500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19201500010', 7020, 34, '119201500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19201500015', 7020, 34, '119201500015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19201500020', 7020, 34, '119201500020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202000005', 7020, 34, '119202000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202500005', 7020, 34, '119202500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203000005', 7020, 34, '119203000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19204500005', 7020, 34, '119204500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19204500006', 7020, 34, '119204500006702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19204500010', 7020, 34, '119204500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19204500011', 7020, 34, '119204500011702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19204500020', 7020, 34, '119204500020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19204500021', 7020, 34, '119204500021702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19204500025', 7020, 34, '119204500025702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19204500026', 7020, 34, '119204500026702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19205500006', 7020, 34, '119205500006702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19209500010', 7020, 34, '119209500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19209500015', 7020, 34, '119209500015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19209500016', 7020, 34, '119209500016702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500190', 7020, 34, '119909500190702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500199', 7020, 34, '119909500199702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500300', 7020, 34, '119909500300702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500910', 7020, 34, '119909500910702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500915', 7020, 34, '119909500915702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500920', 7020, 34, '119909500920702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500925', 7020, 34, '119909500925702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500930', 7020, 34, '119909500930702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19999500010', 7020, 34, '119999500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19999500015', 7020, 34, '119999500015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19999500020', 7020, 34, '119999500020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19999500030', 7020, 34, '119999500030702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19999500040', 7020, 34, '119999500040702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19999500045', 7020, 34, '119999500045702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19999500050', 7020, 34, '119999500050702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '24100500005', 7020, 34, '124100500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '24400000005', 7020, 34, '124400000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000005', 7020, 34, '125350000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25450000005', 7020, 34, '125450000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25450000010', 7020, 34, '125450000010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25450000020', 7020, 34, '125450000020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25951000010', 7020, 34, '125951000010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25957000010', 7020, 34, '125957000010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500070', 7020, 34, '125959500070702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500071', 7020, 34, '125959500071702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500090', 7020, 34, '125959500090702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500005', 7020, 34, '127049500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27950500125', 7020, 34, '127950500125702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28959500005', 7020, 34, '128959500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '35000000005', 7020, 34, '135000000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 34, '136000000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000001005', 7020, 34, '136000001005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41021000010', 7020, 34, '141021000010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41081100005', 7020, 34, '141081100005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41152500030', 7020, 34, '141152500030702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41352501005', 7020, 34, '141352501005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41352501006', 7020, 34, '141352501006702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900040', 7020, 34, '141600900040702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42200500005', 7020, 34, '142200500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42251300006', 7020, 34, '142251300006702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42251300010', 7020, 34, '142251300010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42251300015', 7020, 34, '142251300015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500005', 7020, 34, '142259500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500020', 7020, 34, '142259500020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500025', 7020, 34, '142259500025702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500095', 7020, 34, '142259500095702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500096', 7020, 34, '142259500096702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500110', 7020, 34, '142259500110702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500111', 7020, 34, '142259500111702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500115', 7020, 34, '142259500115702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500125', 7020, 34, '142259500125702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500005', 7020, 34, '142959500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500010', 7020, 34, '142959500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500100', 7020, 34, '142959500100702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500105', 7020, 34, '142959500105702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500110', 7020, 34, '142959500110702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '43050000005', 7020, 34, '143050000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '43050000010', 7020, 34, '143050000010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '43050000015', 7020, 34, '143050000015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '43050000020', 7020, 34, '143050000020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51030400005', 7020, 34, '151030400005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51152000020', 7020, 34, '151152000020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500005', 7020, 34, '151159500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500010', 7020, 34, '151159500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500011', 7020, 34, '151159500011702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500900', 7020, 34, '151159500900702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51200500005', 7020, 34, '151200500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51202500005', 7020, 34, '151202500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51203000005', 7020, 34, '151203000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51203500005', 7020, 34, '151203500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51204500005', 7020, 34, '151204500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51206500900', 7020, 34, '151206500900702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207000005', 7020, 34, '151207000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207000900', 7020, 34, '151207000900702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207000901', 7020, 34, '151207000901702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207000902', 7020, 34, '151207000902702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207500900', 7020, 34, '151207500900702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51208000005', 7020, 34, '151208000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51208000010', 7020, 34, '151208000010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51208000011', 7020, 34, '151208000011702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51208000015', 7020, 34, '151208000015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51208000020', 7020, 34, '151208000020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209000005', 7020, 34, '151209000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209500005', 7020, 34, '151209500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209500010', 7020, 34, '151209500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209500015', 7020, 34, '151209500015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600900', 7020, 34, '151209600900702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700005', 7020, 34, '151209700005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700010', 7020, 34, '151209700010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700015', 7020, 34, '151209700015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700020', 7020, 34, '151209700020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700025', 7020, 34, '151209700025702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700030', 7020, 34, '151209700030702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700035', 7020, 34, '151209700035702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700040', 7020, 34, '151209700040702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700045', 7020, 34, '151209700045702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700050', 7020, 34, '151209700050702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700055', 7020, 34, '151209700055702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700060', 7020, 34, '151209700060702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700065', 7020, 34, '151209700065702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700070', 7020, 34, '151209700070702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700075', 7020, 34, '151209700075702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700080', 7020, 34, '151209700080702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700085', 7020, 34, '151209700085702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700090', 7020, 34, '151209700090702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700095', 7020, 34, '151209700095702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700100', 7020, 34, '151209700100702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700105', 7020, 34, '151209700105702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700110', 7020, 34, '151209700110702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700115', 7020, 34, '151209700115702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700120', 7020, 34, '151209700120702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700125', 7020, 34, '151209700125702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700130', 7020, 34, '151209700130702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700135', 7020, 34, '151209700135702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700140', 7020, 34, '151209700140702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51300500010', 7020, 34, '151300500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51302000005', 7020, 34, '51302000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51302500005', 7020, 34, '51302500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51302500900', 7020, 34, '151302500900702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51302500901', 7020, 34, '151302500901702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500005', 7020, 34, '51309500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500011', 7020, 34, '151309500011702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500021', 7020, 34, '151309500021702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500026', 7020, 34, '151309500026702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500030', 7020, 34, '151309500030702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500031', 7020, 34, '151309500031702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500035', 7020, 34, '151309500035702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500040', 7020, 34, '151309500040702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500900', 7020, 34, '151309500900702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500901', 7020, 34, '151309500901702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500902', 7020, 34, '151309500902702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309700010', 7020, 34, '151309700010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309700015', 7020, 34, '151309700015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309700020', 7020, 34, '151309700020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309700025', 7020, 34, '151309700025702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309700030', 7020, 34, '151309700030702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309700035', 7020, 34, '151309700035702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309700040', 7020, 34, '151309700040702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309700045', 7020, 34, '151309700045702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309700050', 7020, 34, '151309700050702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309700055', 7020, 34, '151309700055702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309700060', 7020, 34, '151309700060702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51355501006', 7020, 34, '151355501006702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51402500011', 7020, 34, '151402500011702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403500011', 7020, 34, '151403500011702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500011', 7020, 34, '151409500011702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500016', 7020, 34, '151409500016702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500026', 7020, 34, '151409500026702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51451000900', 7020, 34, '151451000900702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51459500010', 7020, 34, '151459500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51459500015', 7020, 34, '151459500015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51459500025', 7020, 34, '151459500025702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51459500900', 7020, 34, '151459500900702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51500500900', 7020, 34, '151500500900702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51501000900', 7020, 34, '151501000900702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51502000006', 7020, 34, '151502000006702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51509500010', 7020, 34, '151509500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51509500011', 7020, 34, '151509500011702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51509500015', 7020, 34, '151509500015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51509500020', 7020, 34, '151509500020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51509700005', 7020, 34, '151509700005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51552000005', 7020, 34, '151552000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51555000005', 7020, 34, '151555000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51559500011', 7020, 34, '151559500011702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51559500016', 7020, 34, '151559500016702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51559500020', 7020, 34, '151559500020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51559500021', 7020, 34, '151559500021702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51609500010', 7020, 34, '151609500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51659700010', 7020, 34, '151659700010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51659700015', 7020, 34, '151659700015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51659700020', 7020, 34, '151659700020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51659700025', 7020, 34, '151659700025702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51659700030', 7020, 34, '151659700030702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000016', 7020, 34, '151701000016702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51704000006', 7020, 34, '151704000006702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51801500010', 7020, 34, '151801500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51801500015', 7020, 34, '151801500015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51801500020', 7020, 34, '151801500020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802000005', 7020, 34, '151802000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51808000005', 7020, 34, '151808000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51808000006', 7020, 34, '151808000006702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51900500900', 7020, 34, '151900500900702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51900500901', 7020, 34, '151900500901702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901000010', 7020, 34, '151901000010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500025', 7020, 34, '151901500025702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500030', 7020, 34, '151901500030702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500041', 7020, 34, '151901500041702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500046', 7020, 34, '151901500046702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500051', 7020, 34, '151901500051702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500060', 7020, 34, '151901500060702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500065', 7020, 34, '151901500065702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500070', 7020, 34, '151901500070702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500200', 7020, 34, '151901500200702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500900', 7020, 34, '151901500900702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902000011', 7020, 34, '151902000011702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500031', 7020, 34, '151902500031702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500035', 7020, 34, '151902500035702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500040', 7020, 34, '151902500040702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500900', 7020, 34, '151902500900702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500901', 7020, 34, '151902500901702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500902', 7020, 34, '151902500902702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000010', 7020, 34, '151903000010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000030', 7020, 34, '151903000030702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000900', 7020, 34, '151903000900702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000901', 7020, 34, '151903000901702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500005', 7020, 34, '151903500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903501010', 7020, 34, '151903501010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000015', 7020, 34, '151904000015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000900', 7020, 34, '151904000900702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000901', 7020, 34, '151904000901702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904500700', 7020, 34, '151904500700702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904500900', 7020, 34, '151904500900702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500031', 7020, 34, '151909500031702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500060', 7020, 34, '151909500060702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500081', 7020, 34, '151909500081702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500086', 7020, 34, '151909500086702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500090', 7020, 34, '151909500090702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500091', 7020, 34, '151909500091702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500096', 7020, 34, '151909500096702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500200', 7020, 34, '151909500200702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500210', 7020, 34, '151909500210702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500900', 7020, 34, '151909500900702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500901', 7020, 34, '151909500901702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500902', 7020, 34, '151909500902702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500903', 7020, 34, '151909500903702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500904', 7020, 34, '151909500904702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500905', 7020, 34, '151909500905702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500906', 7020, 34, '151909500906702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909700005', 7020, 34, '151909700005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909700010', 7020, 34, '151909700010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909700015', 7020, 34, '151909700015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909700020', 7020, 34, '151909700020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909700025', 7020, 34, '151909700025702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909700030', 7020, 34, '151909700030702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909700035', 7020, 34, '151909700035702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909700040', 7020, 34, '151909700040702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52100500005', 7020, 34, '152100500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52301000005', 7020, 34, '152301000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500005', 7020, 34, '152959500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500010', 7020, 34, '152959500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500015', 7020, 34, '152959500015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959700010', 7020, 34, '152959700010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000005', 7020, 34, '153050000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000010', 7020, 34, '153050000010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000015', 7020, 34, '153050000015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000020', 7020, 34, '153050000020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000025', 7020, 34, '153050000025702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000030', 7020, 34, '153050000030702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 34, '159000000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 34, '159000001005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 36, '159000000005702036')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 36, '159000001005702036')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 35, '159000000005702035')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 35, '159000001005702035')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 37, '159000000005702037')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 37, '159000001005702037')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51801500020', 7020, 46, '151801500020702046')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51651500400', 7020, 31, '151651500400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500161', 7020, 31, '111150500161702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500015', 7020, 31, '142959500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904500400', 7020, 18, '151904500400702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500035', 7020, 31, '125559500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51302000900', 7020, 31, '151302000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51600500900', 7020, 31, '151600500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500035', 7020, 31, '151409500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500400', 7020, 31, '151902500400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209500400', 7020, 22, '151209500400702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51651500900', 7020, 31, '151651500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241500010', 7020, 31, '182241500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241500005', 7020, 31, '182241500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241000015', 7020, 31, '182241000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19040500005', 7020, 28, '119040500005702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25100500010', 7020, 31, '125100500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201800005', 7020, 31, '181201800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41024300005', 7020, 31, '141024300005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241300030', 7020, 31, '182241300030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241300025', 7020, 31, '182241300025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25100500020', 7020, 31, '125100500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201800010', 7020, 31, '181201800010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25100500015', 7020, 31, '125100500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201800020', 7020, 31, '181201800020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241000010', 7020, 31, '182241000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241000020', 7020, 31, '182241000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241000025', 7020, 31, '182241000025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500908', 7020, 31, '127049500908702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201800015', 7020, 31, '181201800015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000400', 7020, 31, '151904000400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241000030', 7020, 31, '182241000030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241000035', 7020, 31, '182241000035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201800025', 7020, 31, '181201800025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000400', 7020, 31, '151903000400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000001005', 7020, 46, '159000001005702046')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51302000901', 7020, 31, '151302000901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500041', 7020, 31, '151909500041702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51809501095', 7020, 31, '151809501095702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500050', 7020, 31, '152959500050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41355501005', 7020, 31, '141355501005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41353001005', 7020, 31, '141353001005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202000410', 7020, 31, '119202000410702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802000017', 7020, 31, '151802000017702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802001005', 7020, 31, '151802001005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202001405', 7020, 31, '119202001405702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202001410', 7020, 31, '119202001410702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500098', 7020, 31, '151709500098702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42251300030', 7020, 31, '142251300030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500165', 7020, 31, '116879500165702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500100', 7020, 31, '141159500100702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904500011', 7020, 31, '151904500011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28609500005', 7020, 31, '128609500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '18200000005', 7020, 31, '118200000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500995', 7020, 31, '127049500995702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41080600005', 7020, 31, '141080600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500920', 7020, 31, '127049500920702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500937', 7020, 31, '119049500937702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500207', 7020, 31, '125550500207702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41355500005', 7020, 31, '141355500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '32159500008', 7020, 31, '132159500008702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41024100005', 7020, 31, '141024100005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19503000025', 7020, 31, '119503000025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209700145', 7020, 31, '151209700145702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500009', 7020, 31, '152959500009702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51354001005', 7020, 31, '151354001005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202000405', 7020, 31, '119202000405702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000050', 7020, 31, '151903000050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959501006', 7020, 31, '152959501006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309501021', 7020, 31, '151309501021702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909501083', 7020, 31, '151909501083702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202001505', 7020, 31, '119202001505702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202001015', 7020, 31, '119202001015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19153501007', 7020, 31, '119153501007702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309501015', 7020, 31, '151309501015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202001400', 7020, 31, '119202001400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16990500067', 7020, 31, '116990500067702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42251500020', 7020, 31, '142251500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16990500066', 7020, 31, '116990500066702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16990500053', 7020, 31, '116990500053702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16990500064', 7020, 31, '116990500064702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16990500056', 7020, 31, '116990500056702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16990500063', 7020, 31, '116990500063702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16990500062', 7020, 31, '116990500062702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16990500054', 7020, 31, '116990500054702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16990500057', 7020, 31, '116990500057702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16990500052', 7020, 31, '116990500052702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000045', 7020, 31, '151903000045702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500083', 7020, 31, '151909500083702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000906', 7020, 31, '151903000906702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500070', 7020, 31, '142959500070702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000025', 7020, 31, '151904000025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802500040', 7020, 31, '151802500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500065', 7020, 31, '142959500065702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500150', 7020, 31, '116879500150702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203000037', 7020, 31, '119203000037702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000904', 7020, 31, '151904000904702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203000036', 7020, 31, '119203000036702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802500036', 7020, 31, '151802500036702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41070600165', 7020, 31, '141070600165702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51502500005', 7020, 31, '151502500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28959500021', 7020, 31, '128959500021702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500037', 7020, 31, '142259500037702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500036', 7020, 31, '142259500036702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42250600005', 7020, 31, '142250600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '34151000006', 7020, 31, '134151000006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19951000006', 7020, 31, '119951000006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500004', 7020, 31, '152959500004702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500038', 7020, 31, '142259500038702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28103500007', 7020, 31, '128103500007702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51809501090', 7020, 31, '151809501090702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28959500018', 7020, 31, '128959500018702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202001016', 7020, 31, '119202001016702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203801006', 7020, 31, '119203801006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500120', 7020, 31, '142959500120702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51559500903', 7020, 31, '151559500903702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203000033', 7020, 31, '119203000033702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203000035', 7020, 31, '119203000035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203000034', 7020, 31, '119203000034702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202000018', 7020, 31, '119202000018702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802000016', 7020, 31, '151802000016702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202000017', 7020, 31, '119202000017702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51751500010', 7020, 31, '151751500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909501091', 7020, 31, '151909501091702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51751000010', 7020, 31, '151751000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28159500010', 7020, 31, '128159500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500905', 7020, 31, '151409500905702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500070', 7020, 31, '151409500070702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500065', 7020, 30, '151409500065702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51502500900', 7020, 31, '151502500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51509500901', 7020, 31, '151509500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51459500045', 7020, 31, '151459500045702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500211', 7020, 18, '125550500211702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209500020', 7020, 31, '151209500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500025', 7020, 31, '125959500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28104000005', 7020, 31, '128104000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '62959500020', 7020, 31, '162959500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28103000005', 7020, 31, '128103000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19502000030', 7020, 31, '119502000030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42250500050', 7020, 31, '142250500050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51809500080', 7020, 31, '151809500080702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500120', 7020, 31, '125959500120702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19965000005', 7020, 31, '119965000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500012', 7020, 31, '116879500012702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '18250000005', 7020, 31, '118250000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19901000005', 7020, 31, '119901000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51110000010', 7020, 31, '151110000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51110000006', 7020, 31, '151110000006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51110000011', 7020, 31, '151110000011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500075', 7020, 31, '141159500075702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500115', 7020, 31, '125959500115702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500105', 7020, 31, '125959500105702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500085', 7020, 31, '141159500085702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500070', 7020, 31, '125959500070702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500500', 7020, 31, '125550500500702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51559500035', 7020, 31, '151559500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500039', 7020, 31, '125550500039702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500046', 7020, 31, '142259500046702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500080', 7020, 31, '151159500080702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500020', 7020, 31, '152959500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14411500010', 7020, 31, '114411500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14421500010', 7020, 31, '114421500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14441500010', 7020, 31, '114441500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14451500010', 7020, 31, '114451500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25552000010', 7020, 31, '125552000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28959500126', 7020, 31, '128959500126702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51039500006', 7020, 31, '151039500006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25957000015', 7020, 22, '125957000015702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500115', 7020, 31, '151909500115702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28959500125', 7020, 31, '128959500125702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51601000901', 7020, 31, '151601000901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500018', 7020, 31, '151909500018702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42251500025', 7020, 31, '142251500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500907', 7020, 31, '151909500907702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41959500020', 7020, 31, '141959500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14980500900', 7020, 31, '114980500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25450000020', 7020, 31, '125450000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27044000005', 7020, 29, '127044000005702029')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500096', 7020, 31, '142259500096702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403500015', 7020, 31, '151403500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301500015', 7020, 31, '125301500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500090', 7020, 31, '116879500090702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '61959500020', 7020, 31, '161959500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25100500030', 7020, 31, '125100500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42250500028', 7020, 31, '142250500028702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16392500020', 7020, 31, '116392500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16392000020', 7020, 31, '116392000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16391000020', 7020, 31, '116391000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16391500020', 7020, 31, '116391500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500115', 7020, 31, '142259500115702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16551001005', 7020, 31, '116551001005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51301500900', 7020, 31, '151301500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500805', 7020, 31, '125959500805702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500193', 7020, 31, '151909500193702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000901', 7020, 31, '151904000901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 4, '11904950000570204')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51559500902', 7020, 31, '151559500902702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500098', 7020, 31, '142259500098702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 1, '11904950000570201')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209000010', 7020, 31, '151209000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500005', 7020, 8, '12704950000570208')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209000010', 7020, 22, '151209000010702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000006', 7020, 34, '153050000006702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000006', 7020, 31, '153050000006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500005', 7020, 7, '12704950000570207')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500005', 7020, 6, '12704950000570206')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500055', 7020, 22, '125559500055702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500905', 7020, 31, '151909500905702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500005', 7020, 5, '12704950000570205')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500005', 7020, 4, '12704950000570204')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500005', 7020, 46, '127049500005702046')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500005', 7020, 3, '12704950000570203')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500005', 7020, 2, '12704950000570202')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500055', 7020, 31, '125559500055702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500005', 7020, 1, '12704950000570201')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500911', 7020, 31, '151909500911702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16050500005', 7020, 31, '116050500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500912', 7020, 31, '151909500912702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51809500005', 7020, 31, '151809500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500060', 7020, 31, '151159500060702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52179500005', 7020, 31, '152179500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500902', 7020, 31, '151159500902702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500055', 7020, 31, '151159500055702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500082', 7020, 31, '151909500082702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '12050500005', 7020, 31, '112050500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11050501005', 7020, 31, '111050501005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51808000006', 7020, 31, '151808000006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14331500005', 7020, 31, '114331500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14623000010', 7020, 31, '114623000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41020700010', 7020, 31, '141020700010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14593000010', 7020, 31, '114593000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14633000010', 7020, 31, '114633000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51704000130', 7020, 31, '151704000130702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51704000120', 7020, 31, '151704000120702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500965', 7020, 31, '127049500965702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '13080100050', 7020, 31, '113080100050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51154300800', 7020, 31, '151154300800702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14361500005', 7020, 31, '114361500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14870500005', 7020, 31, '114870500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14910500005', 7020, 31, '114910500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42251300140', 7020, 31, '142251300140702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16052600005', 7020, 31, '116052600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000040', 7020, 31, '151903000040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41049500165', 7020, 31, '141049500165702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500805', 7020, 31, '116879500805702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500042', 7020, 31, '141159500042702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25957000016', 7020, 31, '125957000016702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25957000050', 7020, 31, '125957000050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16109500041', 7020, 31, '116109500041702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500050', 7020, 31, '151159500050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500150', 7020, 31, '111150500150702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19993400015', 7020, 31, '119993400015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81701000005', 7020, 31, '181701000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14191500005', 7020, 31, '114191500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900050', 7020, 31, '141600900050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14912500005', 7020, 31, '114912500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14321500005', 7020, 31, '114321500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14111500005', 7020, 31, '114111500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16051800005', 7020, 31, '116051800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19993400017', 7020, 31, '119993400017702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14911500005', 7020, 31, '114911500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41021000020', 7020, 31, '141021000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500011', 7020, 31, '151309500011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500125', 7020, 31, '116879500125702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500045', 7020, 31, '142959500045702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82130500030', 7020, 31, '182130500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82131000030', 7020, 31, '182131000030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82132000030', 7020, 31, '182132000030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51559500011', 7020, 31, '151559500011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51552000005', 7020, 31, '151552000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500900', 7020, 31, '151409500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51401000900', 7020, 31, '151401000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51302000005', 7020, 31, '151302000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207000900', 7020, 31, '151207000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42251300135', 7020, 31, '142251300135702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42251300130', 7020, 31, '142251300130702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42251300120', 7020, 31, '142251300120702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42251300110', 7020, 31, '142251300110702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42251300100', 7020, 31, '142251300100702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500039', 7020, 31, '142259500039702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500055', 7020, 31, '141159500055702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403500050', 7020, 31, '151403500050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51302000010', 7020, 31, '151302000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000051', 7020, 31, '153050000051702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52304000005', 7020, 31, '152304000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500904', 7020, 31, '151909500904702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51302500005', 7020, 31, '151302500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16382000020', 7020, 31, '116382000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16390500020', 7020, 31, '116390500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16382500020', 7020, 31, '116382500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16381500020', 7020, 31, '116381500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82122000020', 7020, 31, '182122000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82112000020', 7020, 31, '182112000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500097', 7020, 31, '151909500097702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500500', 7020, 31, '151901500500702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51704000135', 7020, 31, '151704000135702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51704000140', 7020, 31, '151704000140702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51704000110', 7020, 31, '151704000110702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51704000100', 7020, 31, '151704000100702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51559500021', 7020, 31, '151559500021702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28959500014', 7020, 31, '128959500014702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500031', 7020, 31, '152959500031702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203000032', 7020, 31, '119203000032702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25957000019', 7020, 31, '125957000019702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500044', 7020, 31, '141159500044702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25957000018', 7020, 31, '125957000018702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25957000017', 7020, 31, '125957000017702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000065', 7020, 31, '153050000065702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25554000006', 7020, 31, '125554000006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19903000010', 7020, 31, '119903000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500092', 7020, 31, '151909500092702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500802', 7020, 31, '125959500802702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500170', 7020, 31, '116879500170702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82810400005', 7020, 31, '182810400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81202000015', 7020, 31, '181202000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000055', 7020, 31, '153050000055702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500056', 7020, 31, '151901500056702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000080', 7020, 31, '153050000080702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000075', 7020, 31, '153050000075702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000070', 7020, 31, '153050000070702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000060', 7020, 31, '153050000060702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000050', 7020, 31, '153050000050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51204500010', 7020, 31, '151204500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51459500035', 7020, 31, '151459500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16381000020', 7020, 31, '116381000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14911000005', 7020, 31, '114911000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '510600', 7020, 31, '1510600702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51060000015', 7020, 34, '151060000015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51060000015', 7020, 31, '151060000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500208', 7020, 31, '125550500208702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500303', 7020, 31, '125550500303702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51060300016', 7020, 34, '151060300016702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500030', 7020, 31, '152959500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500032', 7020, 31, '152959500032702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500033', 7020, 31, '152959500033702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500035', 7020, 31, '152959500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500034', 7020, 31, '152959500034702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500036', 7020, 31, '152959500036702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500037', 7020, 31, '152959500037702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500038', 7020, 31, '152959500038702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500039', 7020, 31, '152959500039702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000800', 7020, 31, '151903000800702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500914', 7020, 31, '151909500914702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51900500011', 7020, 31, '151900500011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14501500010', 7020, 31, '114501500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14899000005', 7020, 31, '114899000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14912000005', 7020, 31, '114912000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82830400005', 7020, 31, '182830400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241600005', 7020, 31, '182241600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52301000005', 7020, 31, '152301000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241600015', 7020, 31, '182241600015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51751000005', 7020, 31, '151751000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500040', 7020, 31, '152959500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500040', 7020, 31, '151409500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '24451000005', 7020, 31, '124451000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '24459500005', 7020, 31, '124459500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500025', 7020, 31, '151909500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52300900005', 7020, 31, '152300900005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19201500010', 7020, 31, '119201500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202000005', 7020, 31, '119202000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19201500015', 7020, 31, '119201500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203000005', 7020, 31, '119203000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '13041100020', 7020, 31, '113041100020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000040', 7020, 31, '153050000040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16371000901', 7020, 31, '116371000901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16371500901', 7020, 31, '116371500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16372000901', 7020, 31, '116372000901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16372500901', 7020, 31, '116372500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16361000901', 7020, 31, '116361000901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16361500901', 7020, 31, '116361500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16362000901', 7020, 31, '116362000901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500500', 7020, 31, '151159500500702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16362500901', 7020, 31, '116362500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '62959500010', 7020, 31, '162959500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '61959500010', 7020, 31, '161959500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16370500901', 7020, 31, '116370500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16360500901', 7020, 31, '116360500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52172500005', 7020, 31, '152172500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41020300020', 7020, 31, '141020300020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19503000030', 7020, 31, '119503000030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19503000010', 7020, 31, '119503000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82820200005', 7020, 31, '182820200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82820300005', 7020, 31, '182820300005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82820400005', 7020, 31, '182820400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82820800005', 7020, 31, '182820800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82820600005', 7020, 31, '182820600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82821000005', 7020, 31, '182821000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82821200005', 7020, 31, '182821200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82821300005', 7020, 31, '182821300005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82821400005', 7020, 31, '182821400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82821600005', 7020, 31, '182821600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82821800005', 7020, 31, '182821800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82822000005', 7020, 31, '182822000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82822200005', 7020, 31, '182822200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82822300005', 7020, 31, '182822300005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82822600005', 7020, 31, '182822600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82822400005', 7020, 31, '182822400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82822800005', 7020, 31, '182822800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000401', 7020, 31, '151903000401702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403500030', 7020, 31, '151403500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82823000005', 7020, 31, '182823000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51152000011', 7020, 31, '151152000011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16109500051', 7020, 31, '116109500051702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51060000016', 7020, 34, '151060000016702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500318', 7020, 31, '125550500318702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500313', 7020, 31, '125550500313702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500302', 7020, 31, '125550500302702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500315', 7020, 31, '125550500315702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19503000020', 7020, 31, '119503000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403500040', 7020, 31, '151403500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403500035', 7020, 31, '151403500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500316', 7020, 31, '125550500316702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500201', 7020, 31, '125550500201702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500304', 7020, 31, '125550500304702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500314', 7020, 31, '125550500314702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500319', 7020, 31, '125550500319702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500312', 7020, 31, '125550500312702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28151000005', 7020, 31, '128151000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500005', 7020, 31, '151409500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19901000020', 7020, 31, '119901000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500030', 7020, 31, '151409500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19205000050', 7020, 31, '119205000050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25309500005', 7020, 31, '125309500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500097', 7020, 31, '151709500097702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51205500900', 7020, 31, '151205500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500065', 7020, 31, '116989500065702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500915', 7020, 31, '151909500915702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42251500015', 7020, 31, '142251500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42251500005', 7020, 31, '142251500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500057', 7020, 31, '125559500057702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500085', 7020, 31, '125959500085702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25309500050', 7020, 31, '125309500050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500130', 7020, 31, '116879500130702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19901000040', 7020, 31, '119901000040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500916', 7020, 31, '151909500916702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500904', 7020, 31, '151901500904702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500008', 7020, 31, '116989500008702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52172000005', 7020, 31, '152172000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500096', 7020, 31, '151709500096702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500060', 7020, 31, '116989500060702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500903', 7020, 31, '151901500903702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500902', 7020, 31, '151901500902702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25951000006', 7020, 31, '125951000006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16551000016', 7020, 31, '116551000016702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16985500016', 7020, 31, '116985500016702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51509500900', 7020, 31, '151509500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500404', 7020, 31, '125550500404702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000031', 7020, 31, '153050000031702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600060', 7020, 31, '151209600060702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600065', 7020, 31, '151209600065702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600070', 7020, 31, '151209600070702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500017', 7020, 31, '125550500017702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000902', 7020, 31, '151904000902702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901000006', 7020, 31, '151901000006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000016', 7020, 31, '153050000016702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902000013', 7020, 31, '151902000013702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902000012', 7020, 31, '151902000012702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902000014', 7020, 31, '151902000014702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500915', 7020, 31, '127049500915702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51809500065', 7020, 31, '151809500065702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202000016', 7020, 31, '119202000016702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202000030', 7020, 31, '119202000030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51302500905', 7020, 31, '151302500905702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203000030', 7020, 31, '119203000030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500802', 7020, 31, '151309500802702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500815', 7020, 31, '125959500815702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28103500006', 7020, 31, '128103500006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28959500004', 7020, 31, '128959500004702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28959500011', 7020, 31, '128959500011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51809500015', 7020, 31, '151809500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16872000015', 7020, 31, '116872000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901000007', 7020, 31, '151901000007702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51809500075', 7020, 31, '151809500075702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51809500070', 7020, 31, '151809500070702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51809500060', 7020, 31, '151809500060702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51809500055', 7020, 31, '151809500055702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51809500050', 7020, 31, '151809500050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51809500045', 7020, 31, '151809500045702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51809500040', 7020, 31, '151809500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51809500035', 7020, 31, '151809500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51809500030', 7020, 31, '151809500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51809500025', 7020, 31, '151809500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51809500020', 7020, 31, '151809500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51509500035', 7020, 31, '151509500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52302500005', 7020, 31, '152302500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209200007', 7020, 31, '151209200007702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500050', 7020, 31, '151903500050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500045', 7020, 31, '151903500045702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500040', 7020, 31, '151903500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51509500040', 7020, 31, '151509500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500035', 7020, 31, '151903500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802500035', 7020, 31, '151802500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802000015', 7020, 31, '151802000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203000031', 7020, 31, '119203000031702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500420', 7020, 31, '151309500420702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209200006', 7020, 31, '151209200006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209000007', 7020, 31, '151209000007702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209000006', 7020, 31, '151209000006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25554000007', 7020, 31, '125554000007702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51204500006', 7020, 31, '151204500006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500016', 7020, 31, '151909500016702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500910', 7020, 31, '151909500910702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500901', 7020, 31, '151159500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500011', 7020, 31, '142959500011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500800', 7020, 31, '151901500800702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500110', 7020, 31, '142959500110702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600040', 7020, 31, '151209600040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27702000010', 7020, 31, '127702000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500041', 7020, 31, '141159500041702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207000020', 7020, 31, '151207000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207000025', 7020, 31, '151207000025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500410', 7020, 31, '151309500410702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500405', 7020, 31, '151309500405702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500402', 7020, 31, '151909500402702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19201000005', 7020, 31, '119201000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500403', 7020, 31, '151909500403702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500415', 7020, 31, '151309500415702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500060', 7020, 31, '151409500060702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500902', 7020, 31, '151902500902702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500046', 7020, 31, '151901500046702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403500011', 7020, 31, '151403500011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500050', 7020, 31, '151409500050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25159500050', 7020, 31, '125159500050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27044000005', 7020, 19, '127044000005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19200500005', 7020, 31, '119200500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19201000010', 7020, 31, '119201000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19201500005', 7020, 31, '119201500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16451000010', 7020, 31, '116451000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901000400', 7020, 31, '151901000400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500010', 7020, 31, '151901500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500777', 7020, 31, '116879500777702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500070', 7020, 31, '141159500070702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 7, '11904950000570207')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 9, '11904950000570209')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 8, '11904950000570208')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 11, '119049500005702011')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 10, '119049500005702010')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 13, '119049500005702013')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 12, '119049500005702012')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 16, '119049500005702016')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 14, '119049500005702014')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 15, '119049500005702015')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 23, '119049500005702023')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 17, '119049500005702017')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 26, '119049500005702026')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 20, '119049500005702020')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 27, '119049500005702027')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 32, '119049500005702032')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 33, '119049500005702033')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 35, '119049500005702035')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 36, '119049500005702036')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 37, '119049500005702037')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 18, '136000000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 22, '136000000005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82122000010', 7020, 31, '182122000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82122000015', 7020, 31, '182122000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500005', 7020, 29, '127049500005702029')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '35000001005', 7020, 18, '135000001005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '35000001005', 7020, 28, '135000001005702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82131000015', 7020, 31, '182131000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82131000020', 7020, 31, '182131000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82132000015', 7020, 31, '182132000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82132000025', 7020, 31, '182132000025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19204500006', 7020, 31, '119204500006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19204500011', 7020, 31, '119204500011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19205500005', 7020, 31, '119205500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19204500026', 7020, 31, '119204500026702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19209500010', 7020, 31, '119209500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51800500005', 7020, 31, '151800500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51801000005', 7020, 31, '151801000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802000005', 7020, 31, '151802000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500200', 7020, 31, '151901500200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51801500005', 7020, 31, '151801500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802500005', 7020, 31, '151802500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51500500005', 7020, 31, '151500500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '18050000005', 7020, 31, '118050000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51809500010', 7020, 31, '151809500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51509500025', 7020, 31, '151509500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51509500011', 7020, 31, '151509500011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '18300000005', 7020, 31, '118300000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '18950500005', 7020, 31, '118950500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '18150000005', 7020, 31, '118150000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '18952000005', 7020, 31, '118952000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51459500040', 7020, 31, '151459500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16250500005', 7020, 31, '116250500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42200500005', 7020, 31, '142200500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42251300010', 7020, 31, '142251300010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500007', 7020, 31, '116879500007702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500065', 7020, 31, '151159500065702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500070', 7020, 31, '151159500070702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51651500901', 7020, 31, '151651500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500096', 7020, 31, '116879500096702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600061', 7020, 31, '151209600061702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16380500020', 7020, 31, '116380500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500905', 7020, 31, '151309500905702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000040', 7020, 31, '119151000040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000021', 7020, 31, '151903000021702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500025', 7020, 31, '152959500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '18990500006', 7020, 31, '118990500006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19120500006', 7020, 31, '119120500006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000010', 7020, 31, '119151000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19121000006', 7020, 31, '119121000006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000020', 7020, 31, '119151000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000045', 7020, 31, '119151000045702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000055', 7020, 31, '119151000055702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000060', 7020, 31, '119151000060702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000065', 7020, 31, '119151000065702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151000095', 7020, 31, '119151000095702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151500015', 7020, 31, '119151500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19151500010', 7020, 31, '119151500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19153500006', 7020, 31, '119153500006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19159500005', 7020, 31, '119159500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19170500006', 7020, 31, '119170500006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19900500005', 7020, 31, '119900500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19503000005', 7020, 31, '119503000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19901000010', 7020, 31, '119901000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19901000015', 7020, 31, '119901000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19901000035', 7020, 31, '119901000035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19901000050', 7020, 31, '119901000050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000051', 7020, 31, '125350000051702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7020, 31, '125301000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000010', 7020, 31, '125350000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25150500005', 7020, 31, '125150500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000049', 7020, 31, '125350000049702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000015', 7020, 31, '125350000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000052', 7020, 31, '125350000052702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000054', 7020, 31, '125350000054702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000050', 7020, 31, '125350000050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000055', 7020, 31, '125350000055702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000053', 7020, 31, '125350000053702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000058', 7020, 31, '125350000058702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000057', 7020, 31, '125350000057702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000056', 7020, 31, '125350000056702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000060', 7020, 31, '125350000060702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000059', 7020, 31, '125350000059702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000062', 7020, 31, '125350000062702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000061', 7020, 31, '125350000061702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000065', 7020, 31, '125350000065702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000063', 7020, 31, '125350000063702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000064', 7020, 31, '125350000064702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000068', 7020, 31, '125350000068702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000070', 7020, 31, '125350000070702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000069', 7020, 31, '125350000069702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000071', 7020, 31, '125350000071702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500005', 7020, 31, '125550500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25450000015', 7020, 31, '125450000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500015', 7020, 31, '125550500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500018', 7020, 31, '125550500018702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51453500005', 7020, 31, '151453500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500010', 7020, 31, '125550500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51559500016', 7020, 31, '151559500016702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51451000005', 7020, 31, '151451000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51450500005', 7020, 31, '151450500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500030', 7020, 31, '125550500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500029', 7020, 31, '125550500029702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500031', 7020, 31, '125550500031702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500033', 7020, 31, '125550500033702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500034', 7020, 31, '125550500034702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500032', 7020, 31, '125550500032702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500035', 7020, 31, '125550500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500036', 7020, 31, '125550500036702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500042', 7020, 31, '125550500042702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500045', 7020, 31, '125550500045702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500047', 7020, 31, '125550500047702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500040', 7020, 31, '125550500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500049', 7020, 31, '125550500049702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500050', 7020, 31, '125550500050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500051', 7020, 31, '125550500051702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500053', 7020, 31, '125550500053702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500054', 7020, 31, '125550500054702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500055', 7020, 31, '125550500055702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500056', 7020, 31, '125550500056702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500075', 7020, 31, '125550500075702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500065', 7020, 31, '125550500065702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500076', 7020, 31, '125550500076702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500060', 7020, 31, '125550500060702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500077', 7020, 31, '125550500077702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500080', 7020, 31, '125550500080702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500090', 7020, 31, '125550500090702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500205', 7020, 31, '125550500205702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500085', 7020, 31, '125550500085702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500305', 7020, 31, '125550500305702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500301', 7020, 31, '125550500301702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500202', 7020, 31, '125550500202702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500310', 7020, 31, '125550500310702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500307', 7020, 31, '125550500307702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500321', 7020, 31, '125550500321702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500317', 7020, 31, '125550500317702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500401', 7020, 31, '125550500401702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500406', 7020, 31, '125550500406702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500402', 7020, 31, '125550500402702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500405', 7020, 31, '125550500405702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500408', 7020, 31, '125550500408702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25551500005', 7020, 31, '125551500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25551000005', 7020, 31, '125551000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25552500005', 7020, 31, '125552500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25553000005', 7020, 31, '125553000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25554000005', 7020, 31, '125554000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500005', 7020, 31, '125559500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500010', 7020, 31, '125559500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500015', 7020, 31, '125559500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500020', 7020, 31, '125559500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500025', 7020, 31, '125559500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500050', 7020, 31, '125559500050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500030', 7020, 31, '125559500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25950500005', 7020, 31, '125950500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27100500005', 7020, 31, '127100500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27101000005', 7020, 31, '127101000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500071', 7020, 31, '125959500071702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27109500005', 7020, 31, '127109500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27101500005', 7020, 31, '127101500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27500000005', 7020, 31, '127500000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28100500005', 7020, 31, '128100500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28101500005', 7020, 31, '128101500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28101000005', 7020, 31, '128101000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28102000005', 7020, 31, '128102000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28652000005', 7020, 31, '128652000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28103500005', 7020, 31, '128103500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28150500005', 7020, 31, '128150500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28900000005', 7020, 31, '128900000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28659500005', 7020, 31, '128659500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28959500005', 7020, 31, '128959500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28959500010', 7020, 31, '128959500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28959500015', 7020, 31, '128959500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28959500130', 7020, 31, '128959500130702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28959500131', 7020, 31, '128959500131702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '34165000005', 7020, 31, '134165000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '35000001005', 7020, 31, '135000001005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500795', 7020, 31, '125550500795702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500048', 7020, 31, '125550500048702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '34155000005', 7020, 31, '134155000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41959500011', 7020, 31, '141959500011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500026', 7020, 31, '141159500026702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500031', 7020, 31, '151902500031702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19040500005', 7020, 4, '11904050000570204')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '59000000005', 7020, 46, '159000000005702046')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25100500025', 7020, 31, '125100500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500126', 7020, 31, '151709500126702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000904', 7020, 31, '151903000904702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000905', 7020, 31, '151903000905702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41049500175', 7020, 31, '141049500175702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16059500', 7020, 31, '116059500702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500075', 7020, 31, '151901500075702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500020', 7020, 31, '125550500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500203', 7020, 31, '125550500203702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500025', 7020, 31, '125550500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500028', 7020, 31, '125550500028702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500040', 7020, 31, '116989500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28659500010', 7020, 31, '128659500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41352500005', 7020, 31, '141352500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52301000900', 7020, 31, '152301000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41040300015', 7020, 31, '141040300015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51204500900', 7020, 31, '151204500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27203500010', 7020, 31, '127203500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27203500015', 7020, 31, '127203500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27203500020', 7020, 31, '127203500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500912', 7020, 31, '127049500912702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27203500025', 7020, 31, '127203500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64303000010', 7020, 31, '164303000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64303200010', 7020, 31, '164303200010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64303400010', 7020, 31, '164303400010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64303600010', 7020, 31, '164303600010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64303800010', 7020, 31, '164303800010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '63301500010', 7020, 31, '163301500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64302200010', 7020, 31, '164302200010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64302000010', 7020, 31, '164302000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64302400010', 7020, 31, '164302400010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64302600010', 7020, 31, '164302600010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64302800010', 7020, 31, '164302800010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500200', 7020, 31, '116879500200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51559500025', 7020, 31, '151559500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19909500190', 7020, 31, '119909500190702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 28, '136000000005702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000000005', 7020, 30, '136000000005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241800035', 7020, 31, '182241800035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500010', 7020, 30, '127049500010702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27044000005', 7020, 30, '127044000005702030')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500100', 7020, 31, '142959500100702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81050500025', 7020, 31, '181050500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500005', 7020, 31, '151909500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81050500030', 7020, 31, '181050500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500031', 7020, 31, '151909500031702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19041000010', 7020, 18, '119041000010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500080', 7020, 5, '11904950008070205')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19040500005', 7020, 6, '11904050000570206')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909501092', 7020, 31, '151909501092702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202001010', 7020, 31, '119202001010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903001005', 7020, 31, '151903001005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500193', 7020, 18, '151909500193702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51206500005', 7020, 22, '151206500005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500020', 7020, 31, '142259500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51501000005', 7020, 31, '151501000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500192', 7020, 18, '151909500192702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51651500005', 7020, 34, '151651500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500900', 7020, 31, '151309500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000016', 7020, 31, '151701000016702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52300900005', 7020, 34, '152300900005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500900', 7020, 29, '151909500900702029')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902000010', 7020, 18, '151902000010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500095', 7020, 34, '151909500095702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902000011', 7020, 18, '151902000011702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902000011', 7020, 31, '151902000011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902000010', 7020, 31, '151902000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51602000005', 7020, 34, '151602000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000025', 7020, 34, '151903000025702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51906000005', 7020, 34, '151906000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500500', 7020, 22, '151903500500702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500500', 7020, 31, '151903500500702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500020', 7020, 31, '151409500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500020', 7020, 34, '151409500020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500010', 7020, 18, '142959500010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51459500025', 7020, 18, '151459500025702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500110', 7020, 34, '151909500110702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51750500005', 7020, 31, '151750500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901000010', 7020, 31, '151901000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500015', 7020, 31, '151909500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901000010', 7020, 18, '151901000010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500191', 7020, 18, '151909500191702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904500900', 7020, 29, '151904500900702029')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500191', 7020, 31, '151909500191702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904500900', 7020, 31, '151904500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500901', 7020, 18, '151909500901702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51206500005', 7020, 18, '151206500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600030', 7020, 31, '151209600030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500901', 7020, 31, '151909500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51200500015', 7020, 18, '151200500015702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51559500010', 7020, 31, '151559500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51900500900', 7020, 31, '151900500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500900', 7020, 31, '151902500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500902', 7020, 31, '151909500902702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500030', 7020, 31, '151909500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500901', 7020, 31, '151902500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51500500005', 7020, 18, '151500500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51501000005', 7020, 18, '151501000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000900', 7020, 31, '151904000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500095', 7020, 31, '142259500095702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000900', 7020, 29, '151904000900702029')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000015', 7020, 31, '151701000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51900500015', 7020, 31, '151900500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41020300006', 7020, 31, '141020300006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500010', 7020, 19, '141159500010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51900500020', 7020, 34, '151900500020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500010', 7020, 34, '141159500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41250400085', 7020, 34, '141250400085702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500011', 7020, 34, '141159500011702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900040', 7020, 31, '141600900040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500005', 7020, 18, '142959500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500020', 7020, 22, '142259500020702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500099', 7020, 34, '142959500099702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500099', 7020, 31, '142959500099702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500205', 7020, 22, '142959500205702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500205', 7020, 34, '142959500205702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500206', 7020, 34, '142959500206702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51029500010', 7020, 28, '151029500010702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51039500010', 7020, 28, '151039500010702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51029500010', 7020, 34, '151029500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51039500010', 7020, 34, '151039500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51030500005', 7020, 34, '151030500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51030500005', 7020, 28, '151030500005702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51152000005', 7020, 1, '15115200000570201')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51152000005', 7020, 19, '151152000005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51152000005', 7020, 26, '151152000005702026')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51152000010', 7020, 10, '151152000010702010')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51200500010', 7020, 19, '151200500010702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51206500900', 7020, 22, '151206500900702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500005', 7020, 31, '151159500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51208000005', 7020, 25, '151208000005702025')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51206500900', 7020, 31, '151206500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51208000010', 7020, 25, '151208000010702025')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207000902', 7020, 22, '151207000902702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51208000015', 7020, 31, '151208000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51208000015', 7020, 22, '151208000015702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600030', 7020, 34, '151209600030702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600900', 7020, 31, '151209600900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600025', 7020, 22, '151209600025702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51301500005', 7020, 18, '151301500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500005', 7020, 31, '151309500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600030', 7020, 18, '151209600030702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500021', 7020, 18, '151309500021702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500020', 7020, 18, '151309500020702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500500', 7020, 34, '151309500500702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500025', 7020, 31, '151309500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500500', 7020, 31, '151309500500702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500400', 7020, 31, '151309500400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500501', 7020, 31, '151309500501702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500551', 7020, 31, '151309500551702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500501', 7020, 34, '151309500501702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500903', 7020, 28, '151309500903702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51354000005', 7020, 31, '151354000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51354000005', 7020, 28, '151354000005702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51400500005', 7020, 34, '151400500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51401000005', 7020, 31, '151401000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51401500005', 7020, 34, '151401500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403500005', 7020, 3, '15140350000570203')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51401500005', 7020, 31, '151401500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403500010', 7020, 34, '151403500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403500005', 7020, 19, '151403500005702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500015', 7020, 31, '151409500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51450500400', 7020, 31, '151450500400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51451000005', 7020, 34, '151451000005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51451000900', 7020, 18, '151451000900702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51451000900', 7020, 31, '151451000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51450500400', 7020, 46, '151450500400702046')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51459500005', 7020, 31, '151459500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51459500500', 7020, 31, '151459500500702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51509500400', 7020, 46, '151509500400702046')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51555000900', 7020, 31, '151555000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51509500400', 7020, 31, '151509500400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51559500015', 7020, 34, '151559500015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51601000400', 7020, 31, '151601000400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51559500500', 7020, 31, '151559500500702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51609500500', 7020, 31, '151609500500702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51601000400', 7020, 46, '151601000400702046')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51651500010', 7020, 34, '151651500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51651500010', 7020, 31, '151651500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51751500005', 7020, 17, '151751500005702017')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51651500500', 7020, 31, '151651500500702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51751500005', 7020, 20, '151751500005702020')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802000006', 7020, 18, '151802000006702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51900500020', 7020, 20, '151900500020702020')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51801000006', 7020, 31, '151801000006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51900500020', 7020, 31, '151900500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500041', 7020, 31, '151901500041702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51900500500', 7020, 31, '151900500500702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500025', 7020, 28, '151901500025702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500041', 7020, 18, '151901500041702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500065', 7020, 31, '151901500065702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500065', 7020, 18, '151901500065702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500200', 7020, 18, '151901500200702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500900', 7020, 31, '151901500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902000010', 7020, 34, '151902000010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500005', 7020, 31, '151902500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500005', 7020, 34, '151902500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500010', 7020, 31, '151902500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500010', 7020, 34, '151902500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500020', 7020, 34, '151902500020702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500031', 7020, 18, '151902500031702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500040', 7020, 18, '151902500040702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500040', 7020, 31, '151902500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500400', 7020, 34, '151902500400702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500901', 7020, 22, '151902500901702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000025', 7020, 18, '151903000025702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000025', 7020, 31, '151903000025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500500', 7020, 31, '151902500500702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000900', 7020, 31, '151903000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000902', 7020, 31, '151903000902702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000500', 7020, 31, '151903000500702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500005', 7020, 28, '151903500005702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500015', 7020, 18, '151903500015702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500010', 7020, 34, '151903500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500015', 7020, 34, '151903500015702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500400', 7020, 31, '151903500400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500400', 7020, 46, '151903500400702046')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500025', 7020, 22, '151903500025702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000005', 7020, 18, '151904000005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000010', 7020, 34, '151904000010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000010', 7020, 18, '151904000010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904500005', 7020, 25, '151904500005702025')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000015', 7020, 18, '151904000015702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000015', 7020, 31, '151904000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904500551', 7020, 31, '151904500551702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500020', 7020, 18, '151909500020702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500030', 7020, 19, '151909500030702019')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500070', 7020, 31, '151909500070702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904500005', 7020, 46, '151904500005702046')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500096', 7020, 18, '151909500096702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500095', 7020, 31, '151909500095702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500200', 7020, 18, '151909500200702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500210', 7020, 18, '151909500210702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500192', 7020, 22, '151909500192702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500400', 7020, 31, '151909500400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500400', 7020, 46, '151909500400702046')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500551', 7020, 34, '151909500551702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500500', 7020, 31, '151909500500702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500901', 7020, 29, '151909500901702029')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500903', 7020, 31, '151909500903702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500550', 7020, 34, '151909500550702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500906', 7020, 31, '151909500906702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52301000010', 7020, 34, '152301000010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52951500010', 7020, 34, '152951500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500005', 7020, 18, '152959500005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52300800005', 7020, 34, '152300800005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500010', 7020, 18, '152959500010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500200', 7020, 31, '152959500200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500200', 7020, 34, '152959500200702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500200', 7020, 22, '152959500200702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19040500005', 7020, 8, '11904050000570208')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500020', 7020, 18, '142259500020702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500205', 7020, 34, '152959500205702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500020', 7020, 46, '142259500020702046')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51200300005', 7020, 18, '151200300005702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51200300005', 7020, 34, '151200300005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51200300005', 7020, 46, '151200300005702046')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202001005', 7020, 31, '119202001005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802001010', 7020, 31, '151802001010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51200500010', 7020, 46, '151200500010702046')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51201500005', 7020, 34, '151201500005702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51200500010', 7020, 34, '151200500010702034')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51201500005', 7020, 46, '151201500005702046')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241500035', 7020, 31, '182241500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802500006', 7020, 31, '151802500006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51409500016', 7020, 31, '151409500016702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500400', 7020, 46, '151309500400702046')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81959500999', 7020, 22, '181959500999702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81959500999', 7020, 28, '181959500999702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81959501005', 7020, 28, '181959501005702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81959501005', 7020, 22, '181959501005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '83050000005', 7020, 28, '183050000005702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '83050000005', 7020, 22, '183050000005702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28109500005', 7020, 31, '128109500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600901', 7020, 31, '151209600901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41901000005', 7020, 31, '141901000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51459500902', 7020, 31, '151459500902702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41900500005', 7020, 31, '141900500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500010', 7020, 18, '127049500010702018')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51200500900', 7020, 22, '151200500900702022')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51200500900', 7020, 31, '151200500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903501010', 7020, 31, '151903501010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82050500006', 7020, 31, '182050500006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000010', 7020, 31, '151903000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51200500800', 7020, 31, '151200500800702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '18990500005', 7020, 31, '118990500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '18990500010', 7020, 31, '118990500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51703000005', 7020, 31, '151703000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51703000010', 7020, 31, '151703000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '34151000005', 7020, 31, '134151000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51703000015', 7020, 31, '151703000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '34151000010', 7020, 31, '134151000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '34151000015', 7020, 31, '134151000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19951000010', 7020, 31, '119951000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19951000015', 7020, 31, '119951000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500040', 7020, 31, '151159500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41352500005', 7020, 28, '141352500005702028')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '36000001005', 7020, 31, '136000001005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '35000000005', 7020, 31, '135000000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51154300900', 7020, 31, '151154300900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500055', 7020, 31, '151309500055702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500075', 7020, 31, '142959500075702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51700300005', 7020, 31, '151700300005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500600', 7020, 31, '125959500600702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000035', 7020, 31, '153050000035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500035', 7020, 31, '142259500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51300500900', 7020, 31, '151300500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51609500900', 7020, 31, '151609500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500047', 7020, 31, '141159500047702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500046', 7020, 31, '141159500046702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500043', 7020, 31, '141159500043702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19903000005', 7020, 31, '119903000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500910', 7020, 31, '127049500910702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27950500011', 7020, 31, '127950500011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51609500905', 7020, 31, '151609500905702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51609500025', 7020, 31, '151609500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51459500020', 7020, 31, '151459500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000030', 7020, 31, '153050000030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '54050500010', 7020, 31, '154050500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52101500005', 7020, 31, '152101500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500900', 7020, 31, '151909500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51704000005', 7020, 31, '151704000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51459500015', 7020, 31, '151459500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51551000005', 7020, 31, '151551000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500190', 7020, 31, '151909500190702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500045', 7020, 31, '151909500045702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500110', 7020, 31, '151909500110702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51906000005', 7020, 31, '151906000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000901', 7020, 31, '151903000901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500900', 7020, 31, '151159500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000020', 7020, 31, '151903000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500020', 7020, 31, '151901500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41071200160', 7020, 31, '141071200160702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51900500901', 7020, 31, '151900500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51602000005', 7020, 31, '151602000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51555000005', 7020, 31, '151555000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41500500005', 7020, 31, '141500500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42101500005', 7020, 31, '142101500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51509500020', 7020, 31, '151509500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51509500030', 7020, 31, '151509500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51459500030', 7020, 31, '151459500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500907', 7020, 31, '151309500907702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500040', 7020, 31, '151309500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500902', 7020, 31, '151309500902702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42251300020', 7020, 31, '142251300020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500021', 7020, 31, '151309500021702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500026', 7020, 31, '151309500026702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51302500011', 7020, 31, '151302500011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51301500005', 7020, 31, '151301500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51208000900', 7020, 31, '151208000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51250400005', 7020, 31, '151250400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207500900', 7020, 31, '151207500900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500020', 7020, 31, '151159500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42251500010', 7020, 31, '142251500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41071200175', 7020, 31, '141071200175702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500065', 7020, 31, '141159500065702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500120', 7020, 31, '116879500120702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500040', 7020, 31, '142959500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500105', 7020, 31, '142959500105702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42251300145', 7020, 31, '142251300145702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51200500400', 7020, 31, '151200500400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51200300400', 7020, 31, '151200300400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209500400', 7020, 31, '151209500400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51201500400', 7020, 31, '151201500400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51201000400', 7020, 31, '151201000400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207000401', 7020, 31, '151207000401702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51202500400', 7020, 31, '151202500400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207500400', 7020, 31, '151207500400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51204500400', 7020, 31, '151204500400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51205000400', 7020, 31, '151205000400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51208000400', 7020, 31, '151208000400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51203000400', 7020, 31, '151203000400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207000400', 7020, 31, '151207000400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209200400', 7020, 31, '151209200400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51203500400', 7020, 31, '151203500400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600400', 7020, 31, '151209600400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000026', 7020, 31, '153050000026702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201600020', 7020, 31, '181201600020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201600005', 7020, 31, '181201600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201600015', 7020, 31, '181201600015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201600010', 7020, 31, '181201600010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500120', 7020, 31, '142259500120702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500028', 7020, 31, '125559500028702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201100005', 7020, 31, '181201100005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202000400', 7020, 31, '119202000400702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28959500132', 7020, 31, '128959500132702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500060', 7020, 31, '125559500060702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500056', 7020, 31, '125559500056702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500054', 7020, 31, '125559500054702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500053', 7020, 31, '125559500053702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16051800010', 7020, 31, '116051800010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16052200010', 7020, 31, '116052200010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16052400010', 7020, 31, '116052400010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16052600010', 7020, 31, '116052600010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000045', 7020, 31, '151701000045702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500052', 7020, 31, '125559500052702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500051', 7020, 31, '125559500051702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500033', 7020, 31, '125559500033702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500034', 7020, 31, '125559500034702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500032', 7020, 31, '125559500032702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500031', 7020, 31, '125559500031702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500029', 7020, 31, '125559500029702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500027', 7020, 31, '125559500027702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500024', 7020, 31, '125559500024702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500023', 7020, 31, '125559500023702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500026', 7020, 31, '125559500026702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51900500902', 7020, 31, '151900500902702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500022', 7020, 31, '125559500022702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25559500021', 7020, 31, '125559500021702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25553000010', 7020, 31, '125553000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25553000015', 7020, 31, '125553000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25551000020', 7020, 31, '125551000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25551000015', 7020, 31, '125551000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28959500006', 7020, 31, '128959500006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500901', 7020, 31, '151901500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500015', 7020, 31, '151902500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51801500006', 7020, 31, '151801500006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500020', 7020, 31, '151902500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500906', 7020, 31, '151309500906702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500201', 7020, 31, '151901500201702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82833000005', 7020, 31, '182833000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82832600005', 7020, 31, '182832600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28151000010', 7020, 31, '128151000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16966700010', 7020, 31, '116966700010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16966600005', 7020, 31, '116966600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16966700005', 7020, 31, '116966700005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000016', 7020, 31, '151904000016702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64303800005', 7020, 31, '164303800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64303600005', 7020, 31, '164303600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64303400005', 7020, 31, '164303400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41024100010', 7020, 31, '141024100010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64303200005', 7020, 31, '164303200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41603500005', 7020, 31, '141603500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64303000005', 7020, 31, '164303000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41020300010', 7020, 31, '141020300010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16966400005', 7020, 31, '116966400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16966300005', 7020, 31, '116966300005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16965700005', 7020, 31, '116965700005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16966200005', 7020, 31, '116966200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16965600005', 7020, 31, '116965600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16965400005', 7020, 31, '116965400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16965300005', 7020, 31, '116965300005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16965200005', 7020, 31, '116965200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16372000005', 7020, 31, '116372000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16372500005', 7020, 31, '116372500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16371000005', 7020, 31, '116371000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16371500005', 7020, 31, '116371500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16052800005', 7020, 31, '116052800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16370500005', 7020, 31, '116370500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202000015', 7020, 31, '119202000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500030', 7020, 31, '151159500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81959501005', 7020, 31, '181959501005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82832800005', 7020, 31, '182832800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82832200005', 7020, 31, '182832200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82831800005', 7020, 31, '182831800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82832000005', 7020, 31, '182832000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82832400005', 7020, 31, '182832400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82831200005', 7020, 31, '182831200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14910700005', 7020, 31, '114910700005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14911200005', 7020, 31, '114911200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14911700005', 7020, 31, '114911700005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14912700005', 7020, 31, '114912700005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500080', 7020, 31, '151701500080702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51711000015', 7020, 31, '151711000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14870500007', 7020, 31, '114870500007702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14870500010', 7020, 31, '114870500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14870500012', 7020, 31, '114870500012702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14870500015', 7020, 31, '114870500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14870500017', 7020, 31, '114870500017702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14870500022', 7020, 31, '114870500022702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14870500020', 7020, 31, '114870500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14870500025', 7020, 31, '114870500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14870500027', 7020, 31, '114870500027702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51713000055', 7020, 31, '151713000055702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51713000050', 7020, 31, '151713000050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16991000053', 7020, 31, '116991000053702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16991000052', 7020, 31, '116991000052702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16991000054', 7020, 31, '116991000054702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16991000056', 7020, 31, '116991000056702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16991000057', 7020, 31, '116991000057702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16991000062', 7020, 31, '116991000062702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16991000064', 7020, 31, '116991000064702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16991000066', 7020, 31, '116991000066702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16991000067', 7020, 31, '116991000067702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900065', 7020, 31, '141600900065702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800080', 7020, 31, '141600800080702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000030', 7020, 31, '141606000030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82840200005', 7020, 31, '182840200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800081', 7020, 31, '141600800081702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41606000025', 7020, 31, '141606000025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82840400005', 7020, 31, '182840400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82840600005', 7020, 31, '182840600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82841000005', 7020, 31, '182841000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82840800005', 7020, 31, '182840800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82841200005', 7020, 31, '182841200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82841400005', 7020, 31, '182841400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82841600005', 7020, 31, '182841600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82842000005', 7020, 31, '182842000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51600500005', 7020, 31, '151600500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82842200005', 7020, 31, '182842200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82841800005', 7020, 31, '182841800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19903500005', 7020, 31, '119903500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82843000005', 7020, 31, '182843000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82842400005', 7020, 31, '182842400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19503000035', 7020, 31, '119503000035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16052400005', 7020, 31, '116052400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '53050000004', 7020, 31, '153050000004702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14703000010', 7020, 31, '114703000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500280', 7020, 31, '111150500280702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500211', 7020, 31, '125550500211702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51403500045', 7020, 31, '151403500045702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82831400005', 7020, 31, '182831400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82830600005', 7020, 31, '182830600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82830800005', 7020, 31, '182830800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82831000005', 7020, 31, '182831000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500094', 7020, 31, '151709500094702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82831600005', 7020, 31, '182831600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82813000005', 7020, 31, '182813000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82830200005', 7020, 31, '182830200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82812400005', 7020, 31, '182812400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82812800005', 7020, 31, '182812800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82812600005', 7020, 31, '182812600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82811800005', 7020, 31, '182811800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82812300005', 7020, 31, '182812300005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82812200005', 7020, 31, '182812200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82811300005', 7020, 31, '182811300005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82811200005', 7020, 31, '182811200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82811400005', 7020, 31, '182811400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82811600005', 7020, 31, '182811600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42259500030', 7020, 31, '142259500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500020', 7020, 31, '151909500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25551000010', 7020, 31, '125551000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802500004', 7020, 31, '151802500004702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203000004', 7020, 31, '119203000004702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802000004', 7020, 31, '151802000004702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41070600150', 7020, 31, '141070600150702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202000004', 7020, 31, '119202000004702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202000003', 7020, 31, '119202000003702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901000900', 7020, 31, '151901000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27950500020', 7020, 31, '127950500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203000003', 7020, 31, '119203000003702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52304000900', 7020, 31, '152304000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500045', 7020, 31, '116879500045702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19903500010', 7020, 31, '119903500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51501000900', 7020, 31, '151501000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28109500010', 7020, 31, '128109500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500051', 7020, 31, '125959500051702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241100005', 7020, 31, '182241100005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500017', 7020, 31, '151909500017702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25050500021', 7020, 31, '125050500021702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25050500012', 7020, 31, '125050500012702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '27049500911', 7020, 31, '127049500911702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25309500045', 7020, 31, '125309500045702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19040500005', 7020, 29, '119040500005702029')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19040500005', 7020, 5, '11904050000570205')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81201500050', 7020, 31, '181201500050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500041', 7020, 31, '142959500041702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500006', 7020, 31, '151159500006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82810200005', 7020, 31, '182810200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159500903', 7020, 31, '151159500903702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82810300005', 7020, 31, '182810300005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241600020', 7020, 31, '182241600020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51602000900', 7020, 31, '151602000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82131000025', 7020, 31, '182131000025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241600010', 7020, 31, '182241600010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500055', 7020, 31, '116989500055702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16052200005', 7020, 31, '116052200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '18100000005', 7020, 31, '118100000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25050500016', 7020, 31, '125050500016702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '28103500010', 7020, 31, '128103500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '81740500015', 7020, 31, '181740500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500060', 7020, 31, '116879500060702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51651500005', 7020, 31, '151651500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51402500011', 7020, 31, '151402500011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16985500018', 7020, 31, '116985500018702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500006', 7020, 31, '116989500006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500007', 7020, 31, '116989500007702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500801', 7020, 31, '125959500801702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51709500007', 7020, 31, '151709500007702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500401', 7020, 31, '151909500401702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500950', 7020, 31, '151309500950702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500903', 7020, 31, '151902500903702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000020', 7020, 31, '151904000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51559500901', 7020, 31, '151559500901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16985500017', 7020, 31, '116985500017702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51552000900', 7020, 31, '151552000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000005', 7020, 31, '151903000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207000030', 7020, 31, '151207000030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19201000011', 7020, 31, '119201000011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500908', 7020, 31, '151909500908702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51904000903', 7020, 31, '151904000903702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42251300011', 7020, 31, '142251300011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202000011', 7020, 31, '119202000011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51205000900', 7020, 31, '151205000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51207000903', 7020, 31, '151207000903702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802500030', 7020, 31, '151802500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802500025', 7020, 31, '151802500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802500015', 7020, 31, '151802500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802500020', 7020, 31, '151802500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802000010', 7020, 31, '151802000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203000026', 7020, 31, '119203000026702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203000025', 7020, 31, '119203000025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203000021', 7020, 31, '119203000021702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203000016', 7020, 31, '119203000016702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203000020', 7020, 31, '119203000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203000006', 7020, 31, '119203000006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203000010', 7020, 31, '119203000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203000015', 7020, 31, '119203000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19203000011', 7020, 31, '119203000011702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902000005', 7020, 31, '151902000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500051', 7020, 31, '151901500051702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500035', 7020, 31, '151901500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500030', 7020, 31, '151901500030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51509500005', 7020, 31, '151509500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500025', 7020, 31, '151901500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500200', 7020, 31, '151909500200702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901000005', 7020, 31, '151901000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500015', 7020, 31, '151901500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500005', 7020, 31, '151901500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51651000005', 7020, 31, '151651000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51900500010', 7020, 31, '151900500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51900500005', 7020, 31, '151900500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51650500005', 7020, 31, '151650500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51609500010', 7020, 31, '151609500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51601500005', 7020, 31, '151601500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51609500005', 7020, 31, '151609500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51459500025', 7020, 31, '151459500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500015', 7020, 31, '151309500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202000010', 7020, 31, '119202000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19202000006', 7020, 31, '119202000006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909700010', 7020, 31, '151909700010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909700040', 7020, 31, '151909700040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909700020', 7020, 31, '151909700020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500210', 7020, 31, '151909500210702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500081', 7020, 31, '151909500081702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500091', 7020, 31, '151909500091702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500035', 7020, 31, '151909500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000035', 7020, 31, '151903000035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500050', 7020, 31, '151909500050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500040', 7020, 31, '151909500040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500035', 7020, 31, '151902500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500025', 7020, 31, '151902500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903000030', 7020, 31, '151903000030702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51402000005', 7020, 31, '151402000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500006', 7020, 31, '152959500006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51601000006', 7020, 31, '151601000006702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500115', 7020, 31, '116879500115702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802500016', 7020, 31, '151802500016702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51802500021', 7020, 31, '151802500021702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '42959500035', 7020, 31, '142959500035702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25959500080', 7020, 31, '125959500080702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25552000005', 7020, 31, '125552000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14693000010', 7020, 31, '114693000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14673000010', 7020, 31, '114673000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14683000010', 7020, 31, '114683000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14663000010', 7020, 31, '114663000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14653000010', 7020, 31, '114653000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25050500026', 7020, 31, '125050500026702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82130500020', 7020, 31, '182130500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '32159500005', 7020, 31, '132159500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51030500005', 7020, 31, '151030500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16989500050', 7020, 31, '116989500050702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51601000900', 7020, 31, '151601000900702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25350000020', 7020, 31, '125350000020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16050600010', 7020, 31, '116050600010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16051400010', 7020, 31, '116051400010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16051600010', 7020, 31, '116051600010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16362000005', 7020, 31, '116362000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16975200005', 7020, 31, '116975200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16362500005', 7020, 31, '116362500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16975300005', 7020, 31, '116975300005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16975400005', 7020, 31, '116975400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16975600005', 7020, 31, '116975600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16975700005', 7020, 31, '116975700005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16976200005', 7020, 31, '116976200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16976300005', 7020, 31, '116976300005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16976400005', 7020, 31, '116976400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16976500005', 7020, 31, '116976500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16976600005', 7020, 31, '116976600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800070', 7020, 31, '141600800070702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600800071', 7020, 31, '141600800071702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41020800010', 7020, 31, '141020800010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41600900060', 7020, 31, '141600900060702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41024200010', 7020, 31, '141024200010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701000040', 7020, 31, '151701000040702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500070', 7020, 31, '151701500070702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51701500075', 7020, 31, '151701500075702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '63301500005', 7020, 31, '163301500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64302000005', 7020, 31, '164302000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64302200005', 7020, 31, '164302200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64302400005', 7020, 31, '164302400005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64302600005', 7020, 31, '164302600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '64302800005', 7020, 31, '164302800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241200005', 7020, 31, '182241200005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241700005', 7020, 31, '182241700005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82131500005', 7020, 31, '182131500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241700010', 7020, 31, '182241700010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241700015', 7020, 31, '182241700015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82241700020', 7020, 31, '182241700020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19502800005', 7020, 31, '119502800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600902', 7020, 31, '151209600902702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14040500010', 7020, 31, '114040500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14041000010', 7020, 31, '114041000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14041500010', 7020, 31, '114041500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14042000010', 7020, 31, '114042000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '14042500010', 7020, 31, '114042500010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82811000005', 7020, 31, '182811000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82810500005', 7020, 31, '182810500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82810800005', 7020, 31, '182810800005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51903500800', 7020, 31, '151903500800702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51902500800', 7020, 31, '151902500800702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500802', 7020, 31, '151901500802702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51901500801', 7020, 31, '151901500801702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51900500800', 7020, 31, '151900500800702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51651500800', 7020, 31, '151651500800702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500800', 7020, 31, '151309500800702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500061', 7020, 31, '141159500061702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82810600005', 7020, 31, '182810600005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51909500805', 7020, 31, '151909500805702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51651500020', 7020, 31, '151651500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51302500012', 7020, 31, '151302500012702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51209600066', 7020, 31, '151209600066702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51309500910', 7020, 31, '151309500910702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82112000015', 7020, 31, '182112000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82130500015', 7020, 31, '182130500015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82112000010', 7020, 31, '182112000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82131000010', 7020, 31, '182131000010702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '82130500025', 7020, 31, '182130500025702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500070', 7020, 31, '116879500070702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 3, '11904950000570203')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 2, '11904950000570202')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19049500005', 7020, 6, '11904950000570206')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25957000007', 7020, 31, '125957000007702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '16879500081', 7020, 31, '116879500081702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500410', 7020, 31, '125550500410702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51710500005', 7020, 31, '151710500005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52959500045', 7020, 31, '152959500045702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25957000051', 7020, 31, '125957000051702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '41159500048', 7020, 31, '141159500048702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '19159501005', 7020, 31, '119159501005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51809501005', 7020, 31, '151809501005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '52304000901', 7020, 31, '152304000901702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '51159501005', 7020, 31, '151159501005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '11150500020', 7020, 31, '111150500020702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25552000015', 7020, 31, '125552000015702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '24400000005', 7020, 31, '124400000005702031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301500005', 4069, 28, '25301500005406928')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301500005', 4069, 30, '125301500005406930')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301500005', 4069, 31, '125301500005406931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25550500016', 4069, 30, '125550500016406930')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 2, 31, '125301000005231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 3, 31, '125301000005331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 5, 31, '125301000005531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 6, 31, '125301000005631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7, 31, '125301000005731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4, 31, '125301000005431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8, 31, '125301000005831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 9, 31, '125301000005931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 12, 31, '1253010000051231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 13, 31, '1253010000051331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 14, 31, '1253010000051431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 15, 31, '1253010000051531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 10, 31, '1253010000051031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 11, 31, '1253010000051131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 17, 31, '1253010000051731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 18, 31, '1253010000051831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 20, 31, '1253010000052031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 23, 31, '1253010000052331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 24, 31, '1253010000052431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 25, 31, '1253010000052531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 30, 31, '1253010000053031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 31, 31, '1253010000053131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 22, 31, '1253010000052231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 16, 31, '1253010000051631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 27, 31, '1253010000052731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 29, 31, '1253010000052931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 21, 31, '1253010000052131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 26, 31, '1253010000052631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 19, 31, '1253010000051931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 28, 31, '1253010000052831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 33, 31, '125301000005   3331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 40, 31, '1253010000054031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 35, 31, '1253010000053531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 36, 31, '1253010000053631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 37, 31, '1253010000053731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 38, 31, '1253010000053831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 42, 31, '1253010000054231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 44, 31, '1253010000054431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 45, 31, '1253010000054531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 32, 31, '1253010000053231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 48, 31, '1253010000054831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 53, 31, '1253010000055331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 54, 31, '1253010000055431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 55, 31, '1253010000055531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 56, 31, '1253010000055631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 50, 31, '1253010000055031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 60, 31, '1253010000056031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 62, 31, '1253010000056231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 63, 31, '1253010000056331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 61, 31, '1253010000056131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 52, 31, '1253010000055231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 43, 31, '1253010000054331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 47, 31, '1253010000054731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 41, 31, '1253010000054131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 58, 31, '1253010000055831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 51, 31, '1253010000055131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 34, 31, '1253010000053431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 49, 31, '1253010000054931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 57, 31, '1253010000055731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 59, 31, '1253010000055931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 46, 31, '1253010000054631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 39, 31, '1253010000053931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 114, 31, '125301000005   11431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 113, 31, '125301000005   11331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 115, 31, '125301000005   11531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 128, 31, '125301000005   12831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 127, 31, '125301000005   12731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 126, 31, '125301000005   12631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 124, 31, '125301000005   12431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 123, 31, '125301000005   12331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 122, 31, '125301000005   12231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 121, 31, '125301000005   12131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 120, 31, '125301000005   12031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 119, 31, '125301000005   11931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 118, 31, '125301000005   11831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 117, 31, '125301000005   11731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 116, 31, '125301000005   11631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 102, 31, '125301000005   10231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 103, 31, '125301000005   10331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 104, 31, '125301000005   10431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 105, 31, '125301000005   10531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 106, 31, '125301000005   10631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 108, 31, '125301000005   10831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 99, 31, '125301000005   9931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 100, 31, '125301000005   10031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 101, 31, '125301000005   10131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 98, 31, '125301000005   9831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 97, 31, '125301000005   9731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 96, 31, '125301000005   9631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 94, 31, '125301000005   9431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 93, 31, '125301000005   9331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 92, 31, '125301000005   9231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 91, 31, '125301000005   9131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 90, 31, '125301000005   9031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 89, 31, '125301000005   8931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 88, 31, '125301000005   8831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 87, 31, '125301000005   8731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 86, 31, '125301000005   8631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 85, 31, '125301000005   8531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 84, 31, '125301000005   8431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 109, 31, '125301000005   10931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 110, 31, '125301000005   11031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 111, 31, '125301000005   11131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 125, 31, '125301000005   12531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 78, 31, '1253010000057831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 65, 31, '1253010000056531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 67, 31, '1253010000056731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 68, 31, '1253010000056831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 70, 31, '1253010000057031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 72, 31, '1253010000057231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 74, 31, '1253010000057431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 75, 31, '1253010000057531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 76, 31, '1253010000057631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 80, 31, '1253010000058031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 81, 31, '1253010000058131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 82, 31, '1253010000058231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 71, 31, '1253010000057131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 66, 31, '1253010000056631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 79, 31, '1253010000057931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 69, 31, '1253010000056931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 73, 31, '1253010000057331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 77, 31, '1253010000057731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 64, 31, '1253010000056431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 95, 31, '125301000005   9531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 107, 31, '125301000005   10731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 83, 31, '125301000005   8331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 180, 31, '125301000005   18031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 186, 31, '125301000005   18631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 204, 31, '125301000005   20431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 216, 31, '125301000005   21631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 215, 31, '125301000005   21531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 214, 31, '125301000005   21431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 213, 31, '125301000005   21331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 212, 31, '125301000005   21231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 205, 31, '125301000005   20531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 200, 31, '125301000005   20031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 201, 31, '125301000005   20131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 199, 31, '125301000005   19931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 198, 31, '125301000005   19831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 197, 31, '125301000005   19731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 196, 31, '125301000005   19631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 190, 31, '125301000005   19031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 194, 31, '125301000005   19431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 195, 31, '125301000005   19531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 192, 31, '125301000005   19231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 142, 31, '125301000005   14231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 141, 31, '125301000005   14131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 140, 31, '125301000005   14031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 139, 31, '125301000005   13931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 138, 31, '125301000005   13831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 137, 31, '125301000005   13731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 136, 31, '125301000005   13631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 135, 31, '125301000005   13531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 134, 31, '125301000005   13431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 133, 31, '125301000005   13331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 132, 31, '125301000005   13231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 130, 31, '125301000005   13031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 129, 31, '125301000005   12931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 175, 31, '125301000005   17531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 191, 31, '125301000005   19131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 3921, 31, '125301000005   392131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 3911, 31, '125301000005   391131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 211, 31, '125301000005   21131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 210, 31, '125301000005   21031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 209, 31, '125301000005   20931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 208, 31, '125301000005   20831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 207, 31, '125301000005   20731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 206, 31, '125301000005   20631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 193, 31, '125301000005   19331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 143, 31, '125301000005   14331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 151, 31, '125301000005   15131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 185, 31, '125301000005   18531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 183, 31, '125301000005   18331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 144, 31, '125301000005   14431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 145, 31, '125301000005   14531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 146, 31, '125301000005   14631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 147, 31, '125301000005   14731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4003, 31, '125301000005400331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4005, 31, '125301000005400531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4008, 31, '125301000005400831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4017, 31, '125301000005401731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4018, 31, '125301000005401831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4019, 31, '125301000005401931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4022, 31, '125301000005402231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4024, 31, '125301000005402431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4014, 31, '125301000005401431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4036, 31, '125301000005403631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4032, 31, '125301000005403231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4033, 31, '125301000005403331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4034, 31, '125301000005403431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4043, 31, '125301000005404331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4046, 31, '125301000005404631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4047, 31, '125301000005404731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4049, 31, '125301000005404931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4054, 31, '125301000005405431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4056, 31, '125301000005405631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4057, 31, '125301000005405731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4058, 31, '125301000005405831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4051, 31, '125301000005405131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4060, 31, '125301000005406031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4064, 31, '125301000005406431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4065, 31, '125301000005406531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4067, 31, '125301000005406731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4025, 31, '125301000005402531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4027, 31, '125301000005402731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4030, 31, '125301000005403031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4011, 31, '125301000005401131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4053, 31, '125301000005405331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4059, 31, '125301000005405931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4040, 31, '125301000005404031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4035, 31, '125301000005403531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4016, 31, '125301000005401631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4045, 31, '125301000005404531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4061, 31, '125301000005406131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4007, 31, '125301000005400731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4010, 31, '125301000005401031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4031, 31, '125301000005403131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4050, 31, '125301000005405031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4044, 31, '125301000005404431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4015, 31, '125301000005401531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4006, 31, '125301000005400631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4009, 31, '125301000005400931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 131, 31, '125301000005   13131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 148, 31, '125301000005   14831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 218, 31, '125301000005   21831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 217, 31, '125301000005   21731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 184, 31, '125301000005   18431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 150, 31, '125301000005   15031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 182, 31, '125301000005   18231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 188, 31, '125301000005   18831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 187, 31, '125301000005   18731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 181, 31, '125301000005   18131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 164, 31, '125301000005   16431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 174, 31, '125301000005   17431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 172, 31, '125301000005   17231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 158, 31, '125301000005   15831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 178, 31, '125301000005   17831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 176, 31, '125301000005   17631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 171, 31, '125301000005   17131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 170, 31, '125301000005   17031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 168, 31, '125301000005   16831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 173, 31, '125301000005   17331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 167, 31, '125301000005   16731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 162, 31, '125301000005   16231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 160, 31, '125301000005   16031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 163, 31, '125301000005   16331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 169, 31, '125301000005   16931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 166, 31, '125301000005   16631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 165, 31, '125301000005   16531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 161, 31, '125301000005   16131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 159, 31, '125301000005   15931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 177, 31, '125301000005   17731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 219, 31, '125301000005   21931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 179, 31, '125301000005   17931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7115, 31, '125301000005   711531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7116, 31, '125301000005   711631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7117, 31, '125301000005   711731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8004, 31, '125301000005800431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8002, 31, '125301000005800231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8003, 31, '125301000005800331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8001, 31, '125301000005800131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8009, 31, '125301000005   800931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8008, 31, '125301000005   800831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8000, 31, '125301000005800031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7119, 31, '125301000005   711931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 6004, 31, '125301000005   600431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7100, 31, '125301000005   710031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7093, 31, '125301000005   709331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4069, 28, '25301000005406928')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4069, 30, '125301000005406930')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7993, 31, '125301000005   799331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7995, 31, '125301000005   799531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7994, 31, '125301000005   799431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7991, 31, '125301000005   799131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7990, 31, '125301000005   799031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7989, 31, '125301000005   798931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7988, 31, '125301000005   798831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7053, 31, '125301000005   705331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7987, 31, '125301000005   798731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7986, 31, '125301000005   798631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7985, 31, '125301000005   798531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7533, 31, '125301000005   753331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7090, 31, '125301000005   709031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7091, 31, '125301000005   709131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7092, 31, '125301000005   709231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7055, 31, '125301000005   705531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 6050, 31, '125301000005   605031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 6003, 31, '125301000005   600331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 6002, 31, '125301000005   600231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7042, 31, '125301000005   704231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7196, 31, '125301000005   719631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7194, 31, '125301000005   719431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7193, 31, '125301000005   719331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8020, 31, '125301000005   802031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7192, 31, '125301000005   719231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8018, 31, '125301000005   801831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7195, 31, '125301000005   719531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8024, 31, '125301000005   802431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8025, 31, '125301000005   802531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8022, 31, '125301000005   802231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7007, 31, '125301000005   700731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8023, 31, '125301000005   802331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8026, 31, '125301000005   802631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8021, 31, '125301000005   802131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4069, 31, '125301000005406931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4570, 31, '125301000005   457031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4115, 31, '125301000005   411531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7043, 31, '125301000005   704331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7045, 31, '125301000005   704531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7036, 31, '125301000005   703631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7057, 31, '125301000005   705731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7048, 31, '125301000005   704831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7049, 31, '125301000005   704931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7015, 31, '125301000005   701531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7026, 31, '125301000005   702631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7035, 31, '125301000005   703531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8019, 31, '125301000005   801931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7583, 31, '125301000005   758331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4087, 31, '125301000005   408731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7522, 31, '125301000005   752231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7118, 31, '125301000005   711831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7104, 31, '125301000005   710431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4551, 31, '125301000005   455131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7105, 31, '125301000005   710531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7106, 31, '125301000005   710631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7107, 31, '125301000005   710731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4525, 31, '125301000005   452531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7108, 31, '125301000005   710831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7109, 31, '125301000005   710931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7110, 31, '125301000005   711031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7111, 31, '125301000005   711131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4564, 31, '125301000005   456431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7112, 31, '125301000005   711231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4088, 31, '125301000005   408831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7560, 31, '125301000005   756031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7113, 31, '125301000005   711331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4100, 31, '125301000005   410031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4101, 31, '125301000005   410131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4102, 31, '125301000005   410231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4089, 31, '125301000005   408931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8016, 31, '125301000005   801631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8015, 31, '125301000005   801531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8014, 31, '125301000005   801431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8017, 31, '125301000005   801731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7190, 31, '125301000005   719031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8027, 31, '125301000005   802731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8029, 31, '125301000005   802931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8030, 31, '125301000005   803031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4096, 31, '125301000005   409631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7062, 31, '125301000005   706231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7961, 31, '125301000005   796131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7962, 31, '125301000005   796231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7064, 31, '125301000005706431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7065, 31, '125301000005706531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7068, 31, '125301000005706831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7069, 31, '125301000005706931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7070, 31, '125301000005707031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7071, 31, '125301000005707131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7073, 31, '125301000005707331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7074, 31, '125301000005707431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7078, 31, '125301000005707831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7095, 31, '125301000005709531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7096, 31, '125301000005709631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7097, 31, '125301000005709731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7083, 31, '125301000005708331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7084, 31, '125301000005708431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7085, 31, '125301000005708531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7081, 31, '125301000005708131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7087, 31, '125301000005708731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7088, 31, '125301000005708831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7089, 31, '125301000005708931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7044, 31, '125301000005704431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7046, 31, '125301000005704631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7047, 31, '125301000005704731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7059, 31, '125301000005705931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7056, 31, '125301000005705631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7054, 31, '125301000005705431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7041, 31, '125301000005704131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7052, 31, '125301000005705231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7027, 31, '125301000005702731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7024, 31, '125301000005702431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7022, 31, '125301000005702231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7037, 31, '125301000005703731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7038, 31, '125301000005703831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7029, 31, '125301000005702931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7030, 31, '125301000005703031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7031, 31, '125301000005703131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7032, 31, '125301000005703231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7033, 31, '125301000005703331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7034, 31, '125301000005703431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4097, 31, '125301000005409731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4098, 31, '125301000005409831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4099, 31, '125301000005409931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4078, 31, '125301000005407831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4068, 31, '125301000005406831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4071, 31, '125301000005407131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4072, 31, '125301000005407231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4073, 31, '125301000005407331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4074, 31, '125301000005407431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4075, 31, '125301000005407531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4076, 31, '125301000005407631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4086, 31, '125301000005408631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7001, 31, '125301000005700131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7002, 31, '125301000005700231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7014, 31, '125301000005701431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7018, 31, '125301000005701831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7008, 31, '125301000005700831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7009, 31, '125301000005700931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7010, 31, '125301000005701031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7011, 31, '125301000005701131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7004, 31, '125301000005700431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7006, 31, '125301000005700631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4082, 31, '125301000005408231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7013, 31, '125301000005701331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7077, 31, '125301000005707731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7076, 31, '125301000005707631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7072, 31, '125301000005707231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7082, 31, '125301000005708231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7086, 31, '125301000005708631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7094, 31, '125301000005709431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7021, 31, '125301000005702131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7025, 31, '125301000005702531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7012, 31, '125301000005701231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 6001, 31, '125301000005600131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4081, 31, '125301000005408131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4070, 31, '125301000005407031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7099, 31, '125301000005709931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7080, 31, '125301000005708031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4080, 31, '125301000005408031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7005, 31, '125301000005700531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7017, 31, '125301000005701731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7028, 31, '125301000005702831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7051, 31, '125301000005705131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7067, 31, '125301000005706731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7061, 31, '125301000005706131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7075, 31, '125301000005707531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7040, 31, '125301000005704031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7023, 31, '125301000005702331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 5000, 31, '125301000005500031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4077, 31, '125301000005407731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4079, 31, '125301000005407931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7003, 31, '125301000005700331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7019, 31, '125301000005701931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7016, 31, '125301000005701631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7039, 31, '125301000005703931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7060, 31, '125301000005706031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7079, 31, '125301000005707931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7066, 31, '125301000005706631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7098, 31, '125301000005709831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8012, 31, '125301000005   801231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8013, 31, '125301000005   801331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8028, 31, '125301000005   802831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8031, 31, '125301000005   803131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8032, 31, '125301000005   803231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7687, 31, '125301000005   768731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7633, 31, '125301000005   763331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7733, 31, '125301000005   773331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8010, 31, '125301000005   801031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8011, 31, '125301000005   801131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7134, 31, '125301000005   713431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4113, 31, '125301000005   411331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7191, 31, '125301000005   719131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7197, 31, '125301000005   719731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4114, 31, '125301000005   411431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8005, 31, '125301000005   800531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8006, 31, '125301000005   800631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8034, 31, '125301000005   803431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7554, 31, '125301000005   755431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4571, 31, '125301000005   457131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4112, 31, '125301000005   411231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4111, 31, '125301000005   411131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7130, 31, '125301000005   713031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4110, 31, '125301000005   411031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4109, 31, '125301000005   410931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7129, 31, '125301000005   712931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4108, 31, '125301000005   410831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7128, 31, '125301000005   712831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4107, 31, '125301000005   410731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7127, 31, '125301000005   712731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4106, 31, '125301000005   410631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7126, 31, '125301000005   712631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4105, 31, '125301000005   410531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7125, 31, '125301000005   712531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7124, 31, '125301000005   712431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4104, 31, '125301000005   410431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7123, 31, '125301000005   712331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7122, 31, '125301000005   712231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7121, 31, '125301000005   712131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7120, 31, '125301000005   712031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4103, 31, '125301000005   410331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7103, 31, '125301000005   710331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7101, 31, '125301000005   710131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7587, 31, '125301000005   758731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7114, 31, '125301000005   711431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4670, 31, '125301000005   467031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7527, 31, '125301000005   752731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7617, 31, '125301000005   761731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7976, 31, '125301000005   797631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7917, 31, '125301000005   791731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4117, 31, '125301000005   411731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 4116, 31, '125301000005   411631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8007, 31, '125301000005   800731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8033, 31, '125301000005   803331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7960, 31, '125301000005   796031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7978, 31, '125301000005   797831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7979, 31, '125301000005   797931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7982, 31, '125301000005   798231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7983, 31, '125301000005   798331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 7984, 31, '125301000005   798431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8057, 31, '125301000005   805731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8055, 31, '125301000005   805531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8080, 31, '125301000005   808031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8079, 31, '125301000005   807931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8077, 31, '125301000005   807731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8078, 31, '125301000005   807831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8075, 31, '125301000005   807531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8076, 31, '125301000005   807631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8067, 31, '125301000005   806731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8064, 31, '125301000005   806431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8066, 31, '125301000005   806631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8065, 31, '125301000005   806531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8063, 31, '125301000005   806331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8038, 31, '125301000005   803831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8040, 31, '125301000005   804031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8072, 31, '125301000005   807231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8074, 31, '125301000005   807431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8073, 31, '125301000005   807331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8071, 31, '125301000005   807131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8070, 31, '125301000005   807031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8069, 31, '125301000005   806931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8068, 31, '125301000005   806831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8062, 31, '125301000005   806231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8084, 31, '125301000005   808431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8082, 31, '125301000005   808231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8081, 31, '125301000005   808131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8083, 31, '125301000005   808331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8054, 31, '125301000005   805431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8061, 31, '125301000005   806131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8060, 31, '125301000005   806031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8053, 31, '125301000005   805331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8051, 31, '125301000005   805131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8050, 31, '125301000005   805031')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8047, 31, '125301000005   804731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8045, 31, '125301000005   804531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8046, 31, '125301000005   804631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8049, 31, '125301000005   804931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8048, 31, '125301000005   804831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8044, 31, '125301000005   804431')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8043, 31, '125301000005   804331')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8042, 31, '125301000005   804231')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 9001, 31, '125301000005900131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8085, 31, '125301000005   808531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8039, 31, '125301000005   803931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8035, 31, '125301000005   803531')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8041, 31, '125301000005   804131')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8037, 31, '125301000005   803731')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8059, 31, '125301000005   805931')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8058, 31, '125301000005   805831')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8056, 31, '125301000005   805631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8036, 31, '125301000005   803631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8086, 31, '125301000005   808631')
GO

INSERT INTO dbo.cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
VALUES (1, '25301000005', 8087, 31, '125301000005   808731')
GO
