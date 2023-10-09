-- tabla conectoresuse 
cob_credito
go

truncate table cr_conector_timbrado
-- Timbrado
INSERT INTO cr_conector_timbrado(ct_name_conector, ct_path_salida, ct_path_ingreso, ct_estado, ct_tipo_conector) VALUES('conectorA', '\\192.168.35.30\Workfolder\Timbrado\estcta\carga\conectorA\salida', '', 'V', 'I')
INSERT INTO cr_conector_timbrado(ct_name_conector, ct_path_salida, ct_path_ingreso, ct_estado, ct_tipo_conector) VALUES('conectorB', '\\192.168.35.30\WorkfolderWorkFolder\Timbrado\estcta\carga\conectorB\salida', '', 'V', 'I')
INSERT INTO cr_conector_timbrado(ct_name_conector, ct_path_salida, ct_path_ingreso, ct_estado, ct_tipo_conector) VALUES('conectorC', '\\192.168.35.30\WorkfolderWorkFolder\Timbrado\estcta\carga\conectorC\salida', '', 'V', 'I')
INSERT INTO cr_conector_timbrado(ct_name_conector, ct_path_salida, ct_path_ingreso, ct_estado, ct_tipo_conector) VALUES('conectorD', '\\192.168.35.30\WorkfolderWorkFolder\Timbrado\estcta\carga\conectorD\salida', '', 'V', 'I')

-- Complementos
INSERT INTO cr_conector_timbrado(ct_name_conector, ct_path_salida, ct_path_ingreso, ct_estado, ct_tipo_conector) VALUES('conectorA', '\\192.168.35.30\WorkfolderWorkFolder\Timbrado\comp\carga\conectorA\salida', '', 'V', 'C')
INSERT INTO cr_conector_timbrado(ct_name_conector, ct_path_salida, ct_path_ingreso, ct_estado, ct_tipo_conector) VALUES('conectorB', '\\192.168.35.30\WorkfolderWorkFolder\Timbrado\comp\carga\conectorB\salida', '', 'B', 'C')
INSERT INTO cr_conector_timbrado(ct_name_conector, ct_path_salida, ct_path_ingreso, ct_estado, ct_tipo_conector) VALUES('conectorC', '\\192.168.35.30\WorkfolderWorkFolder\Timbrado\comp\carga\conectorC\salida', '', 'B', 'C')
INSERT INTO cr_conector_timbrado(ct_name_conector, ct_path_salida, ct_path_ingreso, ct_estado, ct_tipo_conector) VALUES('conectorD', '\\192.168.35.30\WorkfolderWorkFolder\Timbrado\comp\carga\conectorD\salida', '', 'B', 'C')

go