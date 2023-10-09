Use cob_cartera
go

IF exists (select 1 from cob_cartera..sysobjects where name = 'ca_tipo_trn')
begin
        delete from cob_cartera..ca_tipo_trn

      insert into cob_cartera..ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable) values ('CAS', 'CASTIGO DE OPERACIONES', 'S', 'S')
      insert into cob_cartera..ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable) values ('DES', 'DESEMBOLSO', 'S', 'S')
      insert into cob_cartera..ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable) values ('EST', 'CAMBIO DE ESTADO', 'N', 'S')
      insert into cob_cartera..ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable) values ('ETM', 'CAMBIO DE ESTADO MANUAL', 'S', 'N')
      insert into cob_cartera..ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable) values ('IOC', 'INGRESO DE OTROS CARGOS', 'S', 'S')
      insert into cob_cartera..ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable) values ('PAG', 'PAGOS', 'S', 'S')
      insert into cob_cartera..ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable) values ('PRV', 'CAUSACION DE INTERESES', 'N', 'S')
      insert into cob_cartera..ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable) values ('RPA', 'REGISTRO DE PAGOS', 'N', 'S')
      insert into cob_cartera..ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable) values ('FND', 'ADMINISTRACION DE FONDOS', 'N', 'S')
      insert into cob_cartera..ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable) values ('GAR', 'ADMINISTRACION DE GARANTIAS', 'N', 'S')
	  insert into cob_cartera..ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable) values ('VEN', 'VENCIMIENTO DE DIVIDENDOS', 'N', 'S')
	  insert into cob_cartera..ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable) values ('SEG', 'SEGUROS EXTERNOS', 'N', 'S')
      insert into cob_cartera..ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable)  values ('REG', 'REGULARIZACION PAGOS OBJETADOS', 'N', 'S') 
      insert into cob_cartera..ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable) values ('DSC', 'DESCUENTO DE TASA', 'N','S')
end
else
    print 'NO EXISTE TABLA ca_tipo_trn'

go
