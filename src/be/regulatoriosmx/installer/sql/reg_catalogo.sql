/************************************************************************/
/*    ARCHIVO:         reg_catalogo.sql                                 */
/*    NOMBRE LOGICO:   reg_catalogo.sql                                 */
/*    PRODUCTO:        REGULATORIOS                                     */
/************************************************************************/
/*                     IMPORTANTE                                       */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                     PROPOSITO                                        */
/*   Script de creacion catalogo tipos de transaccion                   */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      25/08/2016      Ignacio Yupa            Emision Inicial         */  
/************************************************************************/

USE cobis
go

delete from cl_catalogo where tabla in (select codigo from cl_tabla where tabla = 'sb_causa_reportado')
go

delete from cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = 'sb_causa_reportado')
go

delete from cl_tabla where tabla = 'sb_causa_reportado'
go

declare @w_codigo int

select @w_codigo=max(codigo)+1 from cl_tabla
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'sb_causa_reportado', 'Causa de reporte de Operaciones')
insert into cl_catalogo_pro values ('REC', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'APER', 'APERTURA DE CUENTA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'TRIN', 'TRANSACCION DE CLIENTE CON MALAS REFERENCIAS O PEP', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'OPRE', 'OPERACION RELEVANTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'OPRF', 'OPERACION RELEVANTE FRACCIONADA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'OPIN', 'OPERACION INUSUAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'OPPR', 'OPERACION PREOCUPANTE', 'V')
GO

delete from cl_catalogo where tabla in (select codigo from cl_tabla where tabla = 'cl_estados_reportado')
go

delete from cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = 'cl_estados_reportado')
go

delete from cl_tabla where tabla = 'cl_estados_reportado'
go

declare @w_codigo int

select @w_codigo=max(codigo)+1 from cl_tabla
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'cl_estados_reportado', 'Estados Transacciones Reportadas')
insert into cl_catalogo_pro values ('REC', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'G', 'GENERADA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'E', 'ENVIADO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'R', 'REPORTADO', 'V')
GO

delete from cl_catalogo where tabla in (select codigo from cl_tabla where tabla = 'sb_aplicativo_isr')
go

delete from cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = 'sb_aplicativo_isr')
go

delete from cl_tabla where tabla = 'sb_aplicativo_isr'
go

declare @w_codigo int

select @w_codigo = max(codigo) + 1 from cl_tabla
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'sb_aplicativo_isr', 'Aplicativos con Transacciones ISR')
insert into cl_catalogo_pro values ('REC', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'CUENTA DE AHORROS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '14', 'DEPOSITOS A PLAZO FIJO', 'V')
GO


use cobis
go

declare @w_tabla int

select @w_tabla = codigo from cl_tabla where tabla = 'cl_codigo_postal_suc'

if isnull(@w_tabla,0) = 0
begin
    select @w_tabla = isnull(max(codigo), 0) + 1
    from   cobis..cl_tabla

    insert into cobis..cl_tabla (codigo, tabla, descripcion)
    values (@w_tabla,'cl_codigo_postal_suc', 'CODIGO POSTAL SUCURSAL')

    insert into cobis..cl_catalogo_pro (cp_producto, cp_tabla)
    values ('ADM', @w_tabla)

    update cobis..cl_seqnos
    set    siguiente = @w_tabla + 1
    where  tabla = 'cl_tabla'
end


delete from cobis..cl_catalogo where tabla = @w_tabla

INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '99'  , '001', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '1000', '002', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '1001', '003', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '1032', '004', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '1100', '005', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '1101', '006', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '1102', '007', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '1103', '008', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '1104', '009', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '1111', '010', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '2479', '011', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '2480', '012', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '2481', '013', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '2482', '014', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '6898', '015', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '9001', '016', 'V' )
go
