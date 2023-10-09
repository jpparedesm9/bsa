/************************************************************************/
/*  Archivo:            salida_teller.sp                                */
/*  Stored procedure:   sp_salida_teller                                */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 19-Feb-1993                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no autorizado queda  expresamente   prohibido asi como       */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Retorna las lineas pendientes de impresion a teller                 */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA             AUTOR              RAZON                          */
/*  13/Mar/2003      A. Pazmi¤o      Personalización Agro Mercantil     */
/*  02/Mayo/2016     Juan Tagle      Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_salida_teller')
    drop proc sp_salida_teller
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_salida_teller (
@t_trn int,
@t_show_version  bit= 0,
@i_cta_banco cuenta = null,
@i_val money =null,
@o_lp1 varchar(20) ='' out,
@o_lp2 varchar(20) =''  out,
@o_lp3 varchar(20) =''  out,
@o_lp4 varchar(20) =''  out,
@o_lp5 varchar(20) =''  out,
@o_lp6 varchar(20) =''  out,
@o_lp7 varchar(20) =''  out,
@o_lp8 varchar(20) =''  out,
@o_contador tinyint = 0 out,
@o_cab_lp varchar(16)=null out,
@o_control varchar(4)=null out
)
as

declare @w_fecha varchar(10),
        @w_valor money,
        @w_saldo money,
        @w_control smallint,
        @w_nemonico char(4),
        @w_signo char(1),
    @w_nemteller char(1),
    @w_valteller varchar(10),
    @w_contador int,
    @w_ctrlteller varchar(4),
    @w_fechteller varchar(6),
    @w_fechaproc varchar(10),
    @w_control2 smallint,
        @w_saldo_libreta money,
    @w_inicab char(1),
    @w_sp_name varchar(30)

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_salida_teller'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

declare cur_linea_pen cursor
for select fecha,valor,saldo,control,nemonico,signo
from #lpendiente

open cur_linea_pen

fetch cur_linea_pen into
      @w_fecha,
      @w_valor,
      @w_saldo,
      @w_control,
      @w_nemonico,
      @w_signo

while @@fetch_status = 0
  begin
        select @o_contador=@o_contador+1

        if @w_nemonico in ('DPCL','DPSL')
           select @w_nemteller='B'
        else
        if @w_nemonico in ('RECL','RESL')
           select @w_nemteller='J'
        else
        if @w_signo = 'C'
           select @w_nemteller='C'
        else
        if @w_signo = 'D'
           select @w_nemteller='F'

    select @w_valteller=replicate('0',10-(datalength(convert(varchar(20),@w_valor*100))-3))+convert(varchar(20),@w_valor*100)

    select @w_ctrlteller = replicate('0',4-datalength(convert(varchar(4),@w_control)))+convert(varchar(4),@w_control)

    select @w_fechteller=substring(@w_fecha,4,2) + substring(@w_fecha,1,2) + substring(@w_fecha,9,2)

    if @o_contador=1
           select @o_lp1= @w_nemteller + @w_valteller + '.' + 'K' + @w_fechteller + '.'
        else
        if @o_contador=2
           select @o_lp2= @w_nemteller + @w_valteller + '.' + 'K' + @w_fechteller + '.'
        else
    if @o_contador=3
           select @o_lp3= @w_nemteller + @w_valteller + '.' + 'K' + @w_fechteller + '.'
        else
        if @o_contador=4
           select @o_lp4= @w_nemteller + @w_valteller + '.' + 'K' + @w_fechteller + '.'
        else
        if @o_contador=5
           select @o_lp5= @w_nemteller + @w_valteller + '.' + 'K' + @w_fechteller + '.'
        else
        if @o_contador=6
           select @o_lp6= @w_nemteller + @w_valteller + '.' + 'K' + @w_fechteller + '.'
        else
        if @o_contador=7
           select @o_lp7= @w_nemteller + @w_valteller + '.' + 'K' + @w_fechteller + '.'
    else
        if @o_contador=8
           select @o_lp8= @w_nemteller + @w_valteller + '.' + 'K' + @w_fechteller + '.'

         fetch cur_linea_pen into
         @w_fecha,
         @w_valor,
         @w_saldo,
         @w_control,
         @w_nemonico,
         @w_signo

  end

  close cur_linea_pen
  deallocate cur_linea_pen

select @w_fechaproc=convert(varchar(10),fp_fecha,101) from cobis..ba_fecha_proceso
select @w_fechteller=substring(@w_fechaproc,4,2) + substring(@w_fechaproc,1,2) + substring(@w_fechaproc,9,2)
select @w_valteller=replicate('0',10-(datalength(convert(varchar(20),@i_val*100))-3))+convert(varchar(20),@i_val*100)

select @w_control2=ah_control,
       @w_saldo_libreta=ah_saldo_libreta
from cob_ahorros..ah_cuenta
where ah_cta_banco=@i_cta_banco

select @o_control = replicate('0',4-datalength(convert(varchar(4),@w_control2)))+convert(varchar(4),@w_control2)

if @t_trn <>265
begin
   if @t_trn=251
      select @w_inicab='B'
   else
   if @t_trn=261
      select @w_inicab='J'

   select @o_lp8= @w_inicab + @w_valteller + '.' + 'K' + @w_fechteller + '.' + @w_ctrlteller + '.'

   if @o_contador=0
      select @o_lp1= @o_lp8,
             @o_lp8= replicate (' ',21)
   else
   if @o_contador=1
      select @o_lp2= @o_lp8,
             @o_lp8= replicate(' ',21)
   else
   if @o_contador=2
      select @o_lp3 = @o_lp8,
             @o_lp8= replicate(' ',21)
   else
   if @o_contador=3
      select @o_lp4= @o_lp8,
             @o_lp8= replicate(' ',21)
   else
   if @o_contador=4
      select @o_lp5= @o_lp8,
             @o_lp8= replicate(' ',21)
   else
   if @o_contador=5
      select @o_lp6= @o_lp8,
             @o_lp8= replicate(' ',21)
   else
   if @o_contador=6
      select @o_lp7= @o_lp8,
             @o_lp8= replicate(' ',21)
end

select @w_valteller=replicate('0',10-(datalength(convert(varchar(20),@w_saldo_libreta*100))-3))+convert(varchar(20),@w_saldo_libreta*100)

select @o_cab_lp='@'+
       replicate('0',2-datalength(convert(varchar(2),@o_contador)))+convert(varchar(2),@o_contador) +
       '.A' +
       @w_valteller +
       '.'
return 0


go

