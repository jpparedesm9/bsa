/************************************************************************/
/*	Archivo: 		buscacom.sp			        */
/*	Stored procedure: 	sp_buscacom				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     30-julio-1993 				*/
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
/*	   Busquedas al catalogo de comprobantes                        */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		  RAZON				*/
/*	30/Jul/1993	G Jaramillo       Emision Inicial		*/
/*      10/Mar/1995     E Suasti          Consulta Comprobantes por     */
/*                                        varios criterios              */
/*	14/Feb/1997	R.Villota	  Consulta de comprobantes	*/
/*					  de provision y diferidos	*/
/*					  por varios criterios. RV001	*/	
/*	24/Nov/1997	M.V. Garay	  Consulta por sucursal. MVG	*/
/*      11/Mar/1999     C.De Orcajo CMDO  Especifcacion COR043          */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_buscacom')
	drop proc sp_buscacom 
go
create proc sp_buscacom  (
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
	@i_empresa	tinyint = null,
	@i_oficina	smallint = null,
	@i_area  	smallint = null,
	@i_comprobante	int = 0,
	@i_comprobante1	int = 99999999,
	@i_mayorizado	char(1) = null,
	@i_autorizado	char(1) = null,
	@i_fecha_tran	datetime = "01/01/1980",
	@i_fecha_tran1	datetime = "12/31/2099" ,
	@i_oficina1	smallint = null,
	@i_area1	smallint = null,
	@i_comprobante2 int = 99999999,
	@i_automatico   smallint = null,
        @i_formato_fecha tinyint = 1,
        @i_digitador    descripcion = '%',
        @i_referencia    char(10) = null,
        @i_subopcion     tinyint = 0,
	@i_provision	char(1) = null,    /* RV001 */
	@i_tipo		char(1) = null,    /* RV001 */
	@i_estado 	char(1) = null,	   /* RV001 */
	@i_sucursal 	char(1) = null,	   /*MVG*/ 
        @i_cuenta       cuenta = null    /*CMDO*/
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_oficina1	smallint,
	@w_oficina2	smallint,
	@w_oficina3	smallint,            /*CMDO*/
	@w_oficina4	smallint,            /*CMDO*/
	@w_area1	smallint,
	@w_area2	smallint ,
	@w_automat1	smallint,
	@w_automat2	smallint,	
	@w_comprobante	int,
	@w_comprobante1	int,
        @w_cuenta_i     cuenta,      /*CMDO*/
        @w_cuenta_f     cuenta       /*CMDO*/

select @w_today = getdate()
select @w_sp_name = 'sp_buscacom'



/************************************************/
/*  Tipo de Transaccion       			*/

if (@t_trn <> 6115 and @i_operacion = 'S') or
   (@t_trn <> 6128 and @i_operacion = 'O') or
   (@t_trn <> 6130 and @i_operacion = 'A') or
   (@t_trn <> 6204 and @i_operacion = 'Q')/*RV001*/
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end
/************************************************/
if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_empresa 	= @i_empresa,
		i_comprobante	= @i_comprobante,
		i_comprobante1	= @i_comprobante1,
		i_fecha_tran 	= @i_fecha_tran	,
		i_fecha_tran1	= @i_fecha_tran1,
		i_mayorizado 	= @i_mayorizado	 
	exec cobis..sp_end_debug
end 
 
if @i_oficina is null
begin
	select 	@w_oficina1 = 0,
		@w_oficina2 =  32700
end
else begin
	select 	@w_oficina1 = @i_oficina,
		@w_oficina2 = @i_oficina
end
    
/* Inicio - JR990407 */

if @i_cuenta is null
begin
        select  @w_cuenta_i = '1',
                @w_cuenta_f = '9'
end
else begin
        select  @w_cuenta_i = @i_cuenta,
                @w_cuenta_f = @i_cuenta
end

/* Fin   - JR990407 */


if @i_area is null
begin
	select	@w_area1 = 0,
		@w_area2 =  32700
end
else begin
	select 	@w_area1 = @i_area,
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

set  rowcount 20

if @i_operacion = 'O'
Begin
   set  rowcount 20
   if @i_modo = 0
   begin
      set rowcount 20 
      select 'Oficina'      = co_oficina_orig, 
             'Area.'        = co_area_orig  ,
     	     'Numero'       = co_comprobante,
   	     'Fecha'        = convert(char(12),co_fecha_tran,@i_formato_fecha),
   	     'Mayz.'        = co_mayorizado,
             'Aut.'         = co_autorizado,  
   	     'Descripcion'  = substring(co_descripcion,1,35),
             'Digitado'     = substring(co_digitador,1,10) ,
	     'Causa Anulacion'= co_causa_anula,
             'Fecha de Grabacion' = convert(char(12),co_fecha_dig,@i_formato_fecha),
             'Autorizado por' = substring(co_autorizante,1,20)
      from cob_conta..cb_comprobante
      where co_empresa = @i_empresa and
         (co_fecha_tran   between @i_fecha_tran and @i_fecha_tran1) and
         (co_oficina_orig between @w_oficina1 and @w_oficina2) and
         (co_area_orig    between @w_area1   and @w_area2) and
         (co_comprobante  between @i_comprobante and @i_comprobante1) and
         (co_automatico   between @w_automat1 and @w_automat2) and
         (co_mayorizado   like @i_mayorizado) and
         (co_autorizado   like @i_autorizado) and
         (co_digitador    like @i_digitador)
      order by co_oficina_orig,co_area_orig,co_comprobante  
   end
   else
   begin 
     select  'Oficina'      = co_oficina_orig,
             'Area.'        = co_area_orig,
     	     'Numero'       = co_comprobante,
   	     'Fecha'        = convert(char(12),co_fecha_tran,@i_formato_fecha),
   	     'Mayz.'        = co_mayorizado,
             'Aut.'         = co_autorizado,
   	     'Descripcion'  = substring(co_descripcion,1,35),
             'Digitado'     = substring(co_digitador,1,10),
	     'Causa Anulacion'= co_causa_anula,
             'Fecha de Grabacion' = convert(char(12),co_fecha_dig,@i_formato_fecha),
             'Autorizado por' = substring(co_autorizante,1,20)
     from cob_conta..cb_comprobante
       where co_empresa = @i_empresa and
           (co_fecha_tran between @i_fecha_tran and @i_fecha_tran1) and
     (((co_oficina_orig between @i_oficina1 and @w_oficina2) and 
      (co_area_orig     between @i_area1 and @w_area2) and
      (co_comprobante   > @i_comprobante1 and
       co_comprobante   <= @i_comprobante2))  or
     ((co_oficina_orig  between @i_oficina1 and @w_oficina2) and
      (co_area_orig     > @i_area1 and co_area_orig <= @w_area2) and
      (co_comprobante   between @i_comprobante and @i_comprobante2)) or
     ((co_oficina_orig  > @i_oficina1 and co_oficina_orig <= @w_oficina2) and
      (co_area_orig     between @w_area1 and @w_area2) and
      (co_comprobante   between @i_comprobante and @i_comprobante2))) and
         (co_automatico between @w_automat1 and @w_automat2) and
         co_mayorizado  like @i_mayorizado and
         co_autorizado  like @i_autorizado and
         co_digitador   like @i_digitador
      order by co_oficina_orig,co_area_orig,co_comprobante      
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

/* Consulta de Comprobantes Especiales (Provision, Diferidos)
   por Varios Criterios RV001. 
   Similar a la operacion 'O' con adicion de restricciones */



if @i_operacion = 'Q'
   Begin
   if @i_modo = 0
   begin

  
      select distinct 'Oficina'      = co_oficina_orig, 
             'Area.'        = co_area_orig  ,
     	     'Numero'       = co_comprobante,
   	     'Fecha'        = convert(char(12),co_fecha_tran,@i_formato_fecha),
   	     'Mayz.'        = co_mayorizado,
             'Aut.'         = co_autorizado,  
   	     'Descripcion'  = substring(co_descripcion,1,35),
             'Digitado'     = substring(co_digitador,1,10) ,
	     'Causa Anulacion'= co_causa_anula,
             'Fecha de Grabacion' = convert(char(12),co_fecha_dig,@i_formato_fecha),
             'Autorizado por' = substring(co_autorizante,1,20),
	     'Tipo'         = co_tipo_compro
      from cob_conta..cb_comprobante,
           cob_conta..cb_asiento                                     -- JR990407. Esp COR043
      where co_empresa = @i_empresa and
	 (co_fecha_tran   between @i_fecha_tran and @i_fecha_tran1) and 
	 --(co_oficina_orig between @w_oficina1 and @w_oficina2) and -- JR990407. Esp COR043
         --(co_area_orig    between @w_area1   and @w_area2) and     -- JR990407. Esp COR043
	 (as_oficina_dest between @w_oficina1 and @w_oficina2) and   -- JR990407. Esp COR043
         (as_area_dest    between @w_area1   and @w_area2) and       -- JR990407. Esp COR043
	 (co_mayorizado   like @i_mayorizado) and
         (co_autorizado   like @i_autorizado) and
	 (co_tipo_compro  = @i_tipo) and 	/* Comprobante Especial */
	 (co_estado       like @i_estado) and
         co_fecha_tran  = as_fecha_tran   and                         -- JR990407. Esp COR043
         co_comprobante = as_comprobante  and                         -- JR990407. Esp COR043
         co_empresa     = as_empresa      and                         -- JR990407. Esp COR043
         (as_cuenta    between @w_cuenta_i   and @w_cuenta_f)  and       -- JR990407. Esp COR043
         (co_digitador    like @i_digitador) 
         and  co_oficina_orig = as_oficina_orig
      order by co_oficina_orig,co_area_orig,co_comprobante
   end
   else
   begin
      select distinct 'Oficina'      = co_oficina_orig, 
             'Area.'        = co_area_orig  ,
     	     'Numero'       = co_comprobante,
   	     'Fecha'        = convert(char(12),co_fecha_tran,@i_formato_fecha),
   	     'Mayz.'        = co_mayorizado,
             'Aut.'         = co_autorizado,  
   	     'Descripcion'  = substring(co_descripcion,1,35),
             'Digitado'     = substring(co_digitador,1,10) ,
	     'Causa Anulacion'= co_causa_anula,
             'Fecha de Grabacion' = convert(char(12),co_fecha_dig,@i_formato_fecha),
             'Autorizado por' = substring(co_autorizante,1,20),
	     'Tipo'         = co_tipo_compro
      from cob_conta..cb_comprobante,
           cob_conta..cb_asiento                 -- JR990407. Esp COR043
      where co_empresa = @i_empresa and
           (co_fecha_tran between @i_fecha_tran and @i_fecha_tran1) and
     --(((co_oficina_orig between @i_oficina1 and @w_oficina2) and -- JR990407. Esp COR043
       (((as_oficina_dest between @i_oficina1 and @w_oficina2) and -- JR990407. Esp COR043
     --(co_area_orig     between @i_area1 and @w_area2) and        -- JR990407. Esp COR043
       (as_area_dest     between @i_area1 and @w_area2) and        -- JR990407. Esp COR043
      (co_comprobante   > @i_comprobante1 and
       co_comprobante   <= @i_comprobante2))  or
     --((co_oficina_orig  between @i_oficina1 and @w_oficina2) and -- JR990407. Esp COR043
      ((as_oficina_dest  between @i_oficina1 and @w_oficina2) and  -- JR990407. Esp COR043
      --(co_area_orig     > @i_area1 and co_area_orig <= @w_area2) and -- JR990407. Esp COR043
        (as_area_dest     > @i_area1 and as_area_dest <= @w_area2) and -- JR990407. Esp COR043
      (co_comprobante   between @i_comprobante1 and @i_comprobante2)) or
     --((co_oficina_orig  > @i_oficina1 and co_oficina_orig <= @w_oficina2) and -- JR990407. Esp COR043
       ((as_oficina_dest  > @i_oficina1 and as_oficina_dest <= @w_oficina2) and -- JR990407. Esp COR043
      --(co_area_orig     between @w_area1       and @w_area2) and -- JR990407. Esp COR043
        (as_area_dest     between @w_area1       and @w_area2) and -- JR990407. Esp COR043
      (co_comprobante   between @i_comprobante and @i_comprobante2))) and
         (co_automatico between @w_automat1 and @w_automat2) and
         co_mayorizado  like @i_mayorizado and
         co_autorizado  like @i_autorizado and
	 co_estado 	like @i_estado  and
	 co_tipo_compro = @i_tipo and
         co_fecha_tran  = as_fecha_tran  and                    -- JR990407. Esp COR043
         co_comprobante = as_comprobante and                    -- JR990407. Esp COR043
         co_empresa     = as_empresa and                        -- JR990407. Esp COR043
         (as_cuenta    between @w_cuenta_i   and @w_cuenta_f) and  -- JR990407. Esp COR043
         (co_digitador    like @i_digitador)
         and  co_oficina_orig = as_oficina_orig
      order by co_oficina_orig,co_area_orig,co_comprobante
  end
      if @@rowcount = 0
      begin
	      /* 'no existen comprobantes' */
	      exec cobis..sp_cerror
	      @t_debug = @t_debug,
	      @t_file	 = @t_file,
	      @t_from	 = @w_sp_name,
	      @i_num	 = 601060
	      return 1
      end
end -- Operacion Q




if @i_operacion = 'S'
   Begin
   if @i_modo = 0
   begin
      select 'Oficina'     = co_oficina_orig, 
             'Area.'       = co_area_orig  ,
     	     'Numero'      = co_comprobante,
   	     'Fecha'       = convert(char(12),co_fecha_tran,@i_formato_fecha),
   	     'Mayz.'       = co_mayorizado,
             'Autor.'      = co_autorizado,
   	     'Descripcion' = substring(co_descripcion,1,35)
      from cob_conta..cb_comprobante
      where co_empresa    = @i_empresa and
	 (co_oficina_orig between @w_oficina1 and @w_oficina2) and
         (co_area_orig    between @w_area1   and @w_area2) and 
	 (co_comprobante  between @i_comprobante and @i_comprobante1) and 
	 (co_fecha_tran   between @i_fecha_tran and @i_fecha_tran1) and 
	 (co_automatico   between @w_automat1 and @w_automat2) and
	 co_mayorizado    like @i_mayorizado
      order by co_oficina_orig,co_area_orig,co_comprobante
  end
  else
  begin
      select 'Oficina'     = co_oficina_orig,
             'Area.'       = co_area_orig,
     	     'Numero'      = co_comprobante,
   	     'Fecha'       = convert(char(12),co_fecha_tran,@i_formato_fecha),
   	     'Mayz.'       = co_mayorizado,
             'Autor.'      = co_autorizado,
   	     'Descripcion' = substring(co_descripcion,1,35)
      from cob_conta..cb_comprobante
      where co_empresa  = @i_empresa and
	   (co_fecha_tran between @i_fecha_tran and @i_fecha_tran1) and 
     (((co_oficina_orig between @i_oficina1 and @w_oficina2) and
      (co_area_orig     between @i_area1 and @w_area2) and
      (co_comprobante   > @i_comprobante2 and 
       co_comprobante   <= @i_comprobante1))  or
     ((co_oficina_orig  between @i_oficina1 and @w_oficina2) and
      (co_area_orig     > @i_area1 and co_area_orig <= @w_area2) and
      (co_comprobante   between @i_comprobante and @i_comprobante1)) or
     ((co_oficina_orig  > @i_oficina1 and co_oficina_orig <= @w_oficina2) and
      (co_area_orig     between @w_area1 and @w_area2) and
      (co_comprobante   between @i_comprobante and @i_comprobante1)) and
	 (co_automatico between @w_automat1 and @w_automat2) and
	 co_mayorizado  like @i_mayorizado )
      order by co_oficina_orig,co_area_orig,co_comprobante
  end
      if @@rowcount = 0
      begin
	      /* 'no existen comprobantes' */
	      exec cobis..sp_cerror
	      @t_debug = @t_debug,
	      @t_file	 = @t_file,
	      @t_from	 = @w_sp_name,
	      @i_num	 = 601060
	      return 1
      end
end -- operacion 'S'

if @i_operacion = 'A'
   Begin
   if @i_subopcion = 0
      if @i_modo = 0
      begin
         select 'Referencia'= co_referencia,
                'Fecha' = convert(char(10),co_fecha_tran,@i_formato_fecha), 
                'Comprobante' = co_comprobante,
   	        'Descripcion' = substring(co_descripcion,1,62)
           from cb_comprobante    --JRMZ MAR/12/2008
--           from cb_comprobante(2)
          where co_empresa = @i_empresa
            and co_referencia like @i_referencia
            and co_fecha_tran between @i_fecha_tran and @i_fecha_tran1
            order by co_referencia, co_fecha_tran
      end
      else
      begin
         select 'Referencia'= co_referencia,
                'Fecha' = convert(char(10),co_fecha_tran,@i_formato_fecha), 
                'Comprobante' = co_comprobante,
   	        'Descripcion' = substring(co_descripcion,1,62)
           from cb_comprobante    --JRMZ MAR/12/2008
--           from cb_comprobante(2)
          where co_empresa = @i_empresa
            and co_referencia > @i_referencia
            and co_fecha_tran between @i_fecha_tran and @i_fecha_tran1
            order by co_referencia, co_fecha_tran
      end
    

      if @@rowcount = 0
      begin
	      /* 'no existen comprobantes' */
	      exec cobis..sp_cerror
	      @t_debug = @t_debug,
	      @t_file	 = @t_file,
	      @t_from	 = @w_sp_name,
	      @i_num	 = 601060
	      return 1
      end
end -- fin operacion 'A'

return 0
go

