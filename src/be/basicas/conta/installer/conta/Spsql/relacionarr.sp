/************************************************************************/
/*	Archivo: 		relacion.sp				*/
/*	Stored procedure: 	sp_relacion				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           G. Jaramillo                        	*/
/*	Fecha de escritura:     04-Agosto-1993				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	   Mantenimiento al catalogo de Plan General                    */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	04/Ago/1993	G Jaramillo     Emision Inicial			*/
/*	21/Jun/1994	G Jaramillo     Eliminacion de secciones	*/
/*	09-Feb-1999	Juan C. G¢mez	Nuevo par metro y eliminaci¢n 	*/
/*					del substring	JCG10		*/
/*	08-Mar-1999	Juan C. G¢mez	Cambio en el query JCG20	*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_relacion_arr')
	drop proc sp_relacion_arr   
go

create proc sp_relacion_arr    (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
    @s_ofi		smallint = null,
	@t_rty		char(1) = null,
    @t_trn		smallint = null,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_operacion	char(1) = null,
	@i_modo		smallint = null,
	@i_empresa 	tinyint = null,
	@i_cuenta 	cuenta = null,
	@i_oficina 	smallint = null,
	@i_area		smallint = null,
	@i_transer	char(1) = null,
	@i_cuenta1	cuenta = null,
	@i_cuenta2	cuenta = null,
	@i_oficina1	smallint = null,
	@i_area1	smallint = null,
	@i_movimiento	char(1)  = "%",
	@i_sinonimo	char(20) = null,
	@i_error	smallint = null,
	@i_estado	char(1) = 'Z'		--JCG10
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente 	tinyint,	/* siguiente codigo de periodo */
	@w_existe	int,		/* codigo existe = 1 
				               no existe = 0 */

        /* Variables utilizadas en la consulta de una periodo */

	@w_empresa 	tinyint ,
	@w_cuenta 	cuenta,
	@w_movimiento 	char(1),
	@w_nombre	descripcion,
	@w_estado 	char(1) ,
        @flag1 		int, 
	@flag2 		int, 
	@flag3 		int, 
	@padre_cta	cuenta, 
	@padre_area	smallint,
	@padre_oficina	int,
	@temp_oficina	smallint,
	@temp_area	smallint,
	@cuenta_nom 	varchar(64),
	@oficina_nom	varchar(64),
	@w_tipo_plan	char(2),
	@w_depto	char(2),
	@w_moneda	tinyint,
	@w_moneda_base	tinyint,
	@w_extranjera	char(1),
	@w_usadeci	char(1),
	@w_area		smallint,
	@w_area1	smallint,
	@w_area2	smallint,
	@w_oficina1	smallint,
	@w_oficina2	smallint,
	@w_cont 	int 

select @w_today = getdate()
select @w_sp_name = 'sp_relacion_arr'

select @temp_oficina = @i_oficina,
       @temp_area    = @i_area,
       @flag1 = 1

select @w_cuenta = pg_cuenta
  from cob_conta..cb_plan_general
 where pg_empresa = @i_empresa and
       pg_oficina = @i_oficina and
	   pg_area    = @i_area and
	   pg_cuenta  = @i_cuenta 

     while @flag1 > 0
     begin
        if @i_cuenta IS NOT NULL
        begin
                if NOT EXISTS (select * from cb_plan_general
                where   pg_empresa = @i_empresa and
                        pg_oficina = @i_oficina and
                        pg_area    = @i_area and
                        pg_cuenta = @i_cuenta)
                begin
                        insert cb_plan_general (pg_empresa,pg_cuenta,
                                        pg_oficina,pg_area)
                        values (@i_empresa,@i_cuenta,@i_oficina,@i_area)

                        if @@error <> 0
                        begin
              /* 'Error en la insercion de la relacion cuenta-oficina'*/
                           exec cobis..sp_cerror
                           @t_debug = @t_debug,
                           @t_file       = @t_file,
                           @t_from       = @w_sp_name,
                           @i_num        = 601054
                           return 1
						end
                end

                select @padre_cta = cu_cuenta_padre
                from cb_cuenta
                where   cu_empresa = @i_empresa and
                        cu_cuenta = @i_cuenta

                select @i_cuenta = @padre_cta
                continue
        end
        else
        begin
             select @flag1 = 0
             continue
        end 
end
return 0
go
