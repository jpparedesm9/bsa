/************************************************************************/
/*	Archivo: 		buscaaux.sp				*/
/*	Stored procedure: 	sp_buscaaux				*/
/*	Base de datos:  	cob_conta                               */
/*	Producto: 		Contabilidad				*/
/*	Disenado por:  		Gonzalo Jaramillo                       */
/*	Fecha de documentacion:	06/Mar/2000				*/
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
/*                                                                      */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*      06/Marz/2000    V.Narvaez       Emision Inicial                 */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_buscaaux')
	drop proc sp_buscaaux
go

create proc sp_buscaaux(
	@s_ssn			int          = NULL,
 	@s_user			login        = NULL,
	@s_sesn			int          = NULL,
	@s_term			varchar(30)  = NULL,
	@s_date			datetime     = NULL,
	@s_srv			varchar(30)  = NULL,
	@s_lsrv			varchar(30)  = NULL, 
	@s_rol			smallint     = NULL,
	@s_ofi			smallint     = NULL,
	@s_org_err		char(1)      = NULL,
	@s_error		int          = NULL,
	@s_sev			tinyint      = NULL,
	@s_msg			descripcion  = NULL,
	@s_org			char(1)      = NULL,
	@t_debug		char(1)      = 'N',
	@t_file			varchar(14)  = NULL,
	@t_from			varchar(32)  = NULL,
	@i_tabla 	        varchar(30)  = NULL, 
	@i_empresa              tinyint,           
	@i_fecha_tran1          datetime     = '01/01/1980',         
	@i_fecha_tran2          datetime     = '12/31/2099',         
        @i_oficina              smallint     = NULL,
        @i_oficina1             smallint     = NULL,
        @i_consecutivo1         int          = 0,
        @i_consecutivo2         int          = 99999999,
        @i_consecutivo3         int          = 99999999,
        @i_area                 smallint     = NULL,
        @i_area1                smallint     = NULL,
        @i_automatico           int          = NULL,
        @i_operacion            char(1),
        @i_formato_fecha        smallint,
        @i_modo                 tinyint,
        @i_automat3             int          = 32700
	)
as

declare @w_return       int,
        @w_sp_name      varchar(30),
        @w_oficina1     smallint,
        @w_oficina2     smallint,
        @w_area1        smallint,
        @w_area2        smallint,
        @w_automat1     smallint,
        @w_automat2     smallint

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_buscaaux'



if @i_oficina is null
begin
        select  @w_oficina1 = 0,
                @w_oficina2 =  32700
end
else begin
        select  @w_oficina1 = @i_oficina,
                @w_oficina2 = @i_oficina 
end

if @i_area is null
begin
        select  @w_area1 = 0,
                @w_area2 =  32700
end
else begin
        select  @w_area1 = @i_area,
                @w_area2 = @i_area
end

if @i_automatico is null
begin
        select @w_automat1 = 0,
               @w_automat2 =  32700
end
else begin
        select @w_automat1 = @i_automatico,
               @w_automat2 = @i_automatico
end  



if @i_operacion = 'O'
Begin
   set  rowcount 20
   if @i_modo = 0
   begin
      select 'Fecha'   = convert(char(12),sc_fecha_tran, @i_formato_fecha),
             'Oficina' = sc_oficina_orig,
             'Area.'   = sc_area_orig  ,
             'Proceso' = sc_automatico, 
             --'Consecutivo'  = sc_consecutivo,
             'Producto' = sc_producto,
             'Comprobante' = sc_comprobante,
             'Descripcion' = sc_descripcion
        from cob_conta_tercero..ct_scomprobante
       where sc_empresa = @i_empresa 
         and (sc_fecha_tran between @i_fecha_tran1 and @i_fecha_tran2)
         and (sc_oficina_orig between @w_oficina1 and @w_oficina2)
         and (sc_area_orig between @w_area1 and @w_area2)
         and (sc_automatico between @w_automat1 and @w_automat2)
         --and (sc_consecutivo between @i_consecutivo1 and @i_consecutivo2)
         and sc_estado = 'P'
       order by sc_fecha_tran, sc_oficina_orig, sc_area_orig, sc_automatico--, sc_consecutivo
   end
   else
   begin 
      select 'Fecha'   = convert(char(12),sc_fecha_tran, @i_formato_fecha),
             'Oficina' = sc_oficina_orig,
             'Area.'   = sc_area_orig  ,
             'Proceso' = sc_automatico, 
             --'Consecutivo'  = sc_consecutivo,
             'Producto' = sc_producto,
             'Comprobante' = sc_comprobante,
             'Descripcion' = sc_descripcion
        from cob_conta_tercero..ct_scomprobante
       where sc_empresa = @i_empresa 
         and ( 
             ((sc_oficina_orig between @i_oficina1 and @w_oficina2) 
         and (sc_area_orig     between @i_area1 and @w_area2) 
         and (sc_automatico between @i_automat3 and @w_automat2) 
         and (sc_fecha_tran between @i_fecha_tran1 and @i_fecha_tran2) )
         --and (sc_consecutivo   > @i_consecutivo3 and sc_consecutivo <= @i_consecutivo2))  


             or  ((sc_oficina_orig  between  @w_oficina1 and @w_oficina2) 
             and (sc_area_orig     between @w_area1 and @w_area2) 
             and (sc_automatico between @w_automat1 and @w_automat2) 
             and (sc_fecha_tran > @i_fecha_tran1 and sc_fecha_tran <= @i_fecha_tran2) )
             --and (sc_consecutivo  between @i_consecutivo1 and @i_consecutivo2)) 



             or  ((sc_oficina_orig  > @i_oficina1 and sc_oficina_orig < @w_oficina2) 
             and (sc_area_orig     between @w_area1 and @w_area2) 
             and (sc_automatico between @w_automat1 and @w_automat2) 
             and (sc_fecha_tran between @i_fecha_tran1 and @i_fecha_tran2) )
             --and (sc_consecutivo  between @i_consecutivo1 and @i_consecutivo2)) 


             or  ((sc_oficina_orig  between @i_oficina1 and @w_oficina2) 
             and (sc_area_orig     > @i_area1 and sc_area_orig <= @w_area2) 
             and (sc_automatico between @w_automat1 and @w_automat2) 
             and (sc_fecha_tran between @i_fecha_tran1 and @i_fecha_tran2) )
             --and (sc_consecutivo  between @i_consecutivo1 and @i_consecutivo2)) 


             or  ((sc_oficina_orig  between @i_oficina1 and @w_oficina2) 
             and (sc_area_orig     between  @w_area1 and @w_area2) 
             and (sc_automatico > @i_automat3 and sc_automatico <= @w_automat2) 
             and (sc_fecha_tran between @i_fecha_tran1 and @i_fecha_tran2) ) 
             --and (sc_consecutivo  between @i_consecutivo1 and @i_consecutivo2))

             )
         and sc_estado = 'P'
       order by sc_fecha_tran, sc_oficina_orig, sc_area_orig, sc_automatico--, sc_consecutivo
    end

    if @@rowcount = 0
       /* 'no existen comprobantes' */
       exec cobis..sp_cerror
       @t_debug = @t_debug,
       @t_file	 = @t_file,
       @t_from	 = @w_sp_name,
       @i_num	 = 601060
       return 1
end -- operacion 'O'
return 0
go

