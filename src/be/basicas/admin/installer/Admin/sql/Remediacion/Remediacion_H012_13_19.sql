/************************************************************************/
/*          MODIFICACIONES                                              */
/* 25/ABR/2016       ELO     Migracion SYBASE-SQLServer FAL             */

use cobis
go

if not exists (select 1 from sysobjects o, syscolumns c
                where o.name = 'ad_vistas_trnser'
                  and c.id = o.id
                  and c.name = 'vt_campo_rol')
begin
   ALTER TABLE ad_vistas_trnser 
   ADD vt_campo_rol char(20) null 
end 
-- Transacción de Servicio Autorización de funcionalidades

if exists (select 1 from ad_vistas_trnser 
           where vt_producto = 1
             and vt_tabla = 'ts_adm_seguridades' )
   delete ad_vistas_trnser 
           where vt_producto = 1
             and vt_tabla = 'ts_adm_seguridades'
go

insert into ad_vistas_trnser values (1, 'cobis', 'ts_adm_seguridades', 'MANTENIMIENTO DE AUTORIZACION DE FUNCIONALIDADES', 'V', 'fecha', 'secuencia', 'clase',  'N', 'P', 'A',  null, 'usuario', 'terminal_s',  null,  null, 'rol_autorizado')
go

-------------------------------------
-- Transacción de Servicio Modificación de Funcionarios

print 'Registros de ts_funcionario'
if exists (select 1 from ad_vistas_trnser 
           where vt_producto = 1
             and vt_tabla = 'ts_funcionario' )
   delete ad_vistas_trnser 
           where vt_producto = 1
             and vt_tabla = 'ts_funcionario'
go
insert into ad_vistas_trnser values (1, 'cobis', 'ts_funcionario', 'MANTENIMIENTO DE FUNCIONARIOS', 'V', 'fecha', 'secuencia', 'clase',  'N', 'P', 'A',  null, 'usuario', 'terminal_s',  null,  null, null)
go


