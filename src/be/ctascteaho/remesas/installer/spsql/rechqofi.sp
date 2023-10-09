/************************************************************************/
/*  Archivo:            rechqofi.sp                                     */
/*  Stored procedure:   sp_rem_chequexofi                               */
/*  Base de datos:      cob_remesas                                     */
/*  Producto:           Remesas                                         */
/*  Disenado por:                                                       */
/*  Fecha de escritura: 17-Jun-1995                                     */
/************************************************************************/
/*                               IMPORTANTE                             */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de la           */
/*  "NCR CORPORATION".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                               PROPOSITO                              */
/*  Este programa procesa la consulta de cheques de remesas por         */
/*  oficina, tanto en ctas. corrientes como en Ahorros                  */ 
/************************************************************************/
/*                             MODIFICACIONES                           */
/*  FECHA           AUTOR           RAZON                               */
/*  17/Jun/1995     D Villafuerte   Emision Inicial                     */
/*  16/Ene/1996     D Villafuerte   Control de Calidad (#temp)          */
/************************************************************************/

use cob_remesas
go

set ansi_nulls off
go

if exists (select 1 from sysobjects where name = 'sp_rem_chequexofi')
    drop proc sp_rem_chequexofi







go
create proc sp_rem_chequexofi(
    @s_ssn          int,
    @s_srv          varchar(30),
    @s_lsrv         varchar(30),
    @s_user         varchar(30),
    @s_sesn         int=null,
    @s_term         varchar(10),
    @s_date         datetime,
    @s_ofi          smallint,   /* Localidad origen transaccion */
    @s_rol          smallint,
    @s_org_err      char(1) = null, /* Origen de error: [A], [S] */
    @s_error        int = null,
    @s_sev          tinyint = null,
    @s_msg          mensaje = null,
    @s_org          char(1),
    @t_corr         char(1) = 'N',
    @t_ssn_corr     int = null, /* Trans a ser reversada */
    @t_debug        char(1) = 'N',
    @t_file         varchar(14) = null,
    @t_from         varchar(32) = null,
    @t_rty          char(1) = 'N',
    @t_trn          smallint,
    @t_show_version bit    = 0,
    @p_lssn         int = null,
    @p_rssn         int = null,
    @p_rssn_corr    int = null,
    @p_envio        char(1) = 'N',
    @p_rpta         char(1) = 'N',
    @i_oficina      smallint= null,
    @i_oficon       smallint= null,
    @i_moneda       tinyint,
    @i_fecha_desde  smalldatetime,
    @i_fecha_hasta  smalldatetime,     
    @i_tiporem      char(1),
    @i_ultimo       int = 0,
    @i_carta        int = 0
)
as
declare @w_return   int,
    @w_sp_name      varchar(30),
    @w_cta          cuenta,
    @w_ctadep       int,
    @w_producto     tinyint,
    @w_total        money,
    @w_codigo       smallint, 
    @w_ciudad       int, 
    @w_parroquia    int,
    @w_codbco       tinyint 
    
/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_rem_chequexofi'

       if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

/* Chequeo de errores generados remotamente */
if @s_org_err is not null           /*  Error del Sistema  */
begin
    exec cobis..sp_cerror
    @t_from        = @w_sp_name,
    @i_num         = @s_error,
    @i_sev         = @s_sev,
    @i_msg         = @s_msg
    return 1
end

if @t_trn <> 429
begin
    exec cobis..sp_cerror
    @t_from = @w_sp_name,
    @i_num = 351014
    return 1
end

if @i_oficina is null
begin
    exec cobis..sp_cerror
    @t_from     = @w_sp_name,
    @i_num      = 351046,
    @i_msg      = 'CODIGO DE OFICINA ES OBLIGATORIO'
    return 351046
end     

--Codigo propio de compensacion
select @w_codbco = pa_tinyint
from   cobis..cl_parametro 
where  pa_nemonico = 'CBCO' 
and    pa_producto = 'CTE'

if @@rowcount <> 1
begin
   exec cobis..sp_cerror
   @t_from         = @w_sp_name,
   @i_num          = 201196
   return 201196
end


/* Codigo de la ciudad de la oficina consultada */
select @w_ciudad = of_ciudad
from   cobis..cl_oficina
where of_oficina = @i_oficina 

/*Tabla temporal para las cartas de la oficina y fechas requeridas*/
create table #temp ( 
carta       int, 
moneda      tinyint, 
oficina     smallint,
bancoc      int,
parroquiac  int, 
fechaemi    smalldatetime, 
numdias     smallint )

insert into #temp  
select 
ct_carta,     ct_moneda,   ct_oficina, ct_banco_c, ct_ciudad_c, 
ct_fecha_emi, isnull(datediff(dd, ct_fecha_emi, ct_fecha_efe),0)
from  cob_remesas..re_carta
where ct_oficina    = @i_oficina
and   ct_moneda     = @i_moneda 
and   ct_fecha_emi >= @i_fecha_desde
and   ct_fecha_emi <= @i_fecha_hasta
order by ct_carta
/*if @@rowcount = 0
begin
    exec cobis..sp_cerror
    @t_from      = @w_sp_name,
    @i_num       = 351046
    return 351046
end    
*/
if @i_tiporem = 'T' 
begin 
   set rowcount 20
   select    
   'FECHA ING.  ' = convert(char(10),dc_fecha_emi,101),
   'BCO. GIRADOR' = dc_banco_p,
   'OF. DESTINO ' = ct_oficina_c,
   'CARTA'        =  right(('00000000' + convert(varchar(9),dc_carta)),9),  
   'CTA. GIRADA ' = dc_cta_girada,
   'CTA. DEPOSI ' = dc_cta_depositada,      
   'CHEQUE'       = dc_num_cheque,
   'ESTADO'       = substring(c.valor,1,25), 
   'SUB-ESTADO'   = a.valor,
   'DIAS  '       = datediff (dd, dc_fecha_emi, dc_fecha_efe) + 1,  
   'VALOR '       = dc_valor,
   'No.REM'       = dc_cheque,
   'FECHA EFEC.'  = convert(varchar(10),dc_fecha_efe,101),
   'CARTA INT.'   = dc_carta,
   'TIPO CARTA'   = 
         case ct_banco_c
              when @w_codbco then 'VIA INTERNA'
              else 'VIA BANCOS'
         end
   from cob_remesas..re_cheque_rec,
        cob_remesas..re_carta,
        cobis..cl_catalogo c,
        cobis..cl_catalogo a
        right join cob_remesas..re_det_carta
        on  a.codigo = dc_sub_estado
   where cr_oficina = @i_oficina
   and   cr_cheque_rec > @i_ultimo
   and   cr_moneda      = @i_moneda
   and   ct_fecha_emi >= @i_fecha_desde
   and   ct_fecha_emi <= @i_fecha_hasta
   and   ct_carta       = dc_carta
   and   cr_cheque_rec  = dc_cheque
   and   c.tabla = (select cobis..cl_tabla.codigo
                    from cobis..cl_tabla
                   where tabla = 're_tcheque')
   and   c.codigo =  dc_status  
   and   a.tabla = (select codigo from cobis..cl_tabla where tabla ='re_sub_estado')
   
   order by cr_cheque_rec

   set rowcount 0 

   select @w_total = sum(dc_valor)
   from   cob_remesas..re_cheque_rec,
          cob_remesas..re_det_carta,
          cob_remesas..re_carta
   where ct_carta       = dc_carta 
   and   cr_cheque_rec  = dc_cheque
   and   cr_oficina     = @i_oficina
   and   ct_moneda      = @i_moneda
   and   ct_fecha_emi  >= @i_fecha_desde
   and   ct_fecha_emi  <= @i_fecha_hasta
end
else
begin 
   set rowcount 20
   select    
   'FECHA ING.  ' = convert(char(10),dc_fecha_emi,101),
   'BCO. GIRADOR' = dc_banco_p,
   --'OF. DESTINO ' = dc_oficina_p,
   'OF. DESTINO ' = ct_oficina_c,
   'CARTA' =  right(('00000000' + convert(varchar(9),dc_carta)),9),  
   'CTA. GIRADA ' = dc_cta_girada,
   'CTA. DEPOSI ' = dc_cta_depositada,      
   'CHEQUE'       = dc_num_cheque,
   'ESTADO'       = substring(c.valor,1,25), 
   'SUB-ESTADO'   = a.valor,
   'DIAS  '       = datediff (dd, dc_fecha_emi, dc_fecha_efe) + 1,  
   'VALOR '       = dc_valor,
   'No.REM'       = dc_cheque,
   'FECHA EFEC.'  = convert(varchar(10),dc_fecha_efe,101),
   'CARTA INT.'   = dc_carta,
   'TIPO CARTA'   = 
                    case ct_banco_c
                         when @w_codbco then 'VIA INTERNA'
                         else 'VIA BANCOS'
                    end
   from  cob_remesas..re_cheque_rec,
         cob_remesas..re_carta,
         cobis..cl_catalogo c,
         cobis..cl_catalogo a
        right join cob_remesas..re_det_carta 
      on a.codigo      = dc_sub_estado
   where cr_oficina    = @i_oficina
   and   dc_status     = @i_tiporem --   MANEJO DE ESTADOS
   and   cr_cheque_rec > @i_ultimo
   and   cr_moneda     = @i_moneda
   and   ct_fecha_emi >= @i_fecha_desde
   and   ct_fecha_emi <= @i_fecha_hasta
   and   ct_carta       = dc_carta
   and   cr_cheque_rec  = dc_cheque
   and   c.tabla        = (select cobis..cl_tabla.codigo
                           from cobis..cl_tabla
                          where tabla = 're_tcheque')
   and   c.codigo       =  dc_status  
   and   a.tabla        = (select codigo from cobis..cl_tabla where tabla ='re_sub_estado')
   order by cr_cheque_rec

   set rowcount 0 
   select @w_total = sum(dc_valor)
   from  cob_remesas..re_cheque_rec,
         cob_remesas..re_det_carta,
         cob_remesas..re_carta
   where ct_carta     = dc_carta 
   and   cr_cheque_rec  = dc_cheque
   and   dc_status    = @i_tiporem
   and   cr_oficina   = @i_oficina
   and   ct_moneda     = @i_moneda
   and   ct_fecha_emi >= @i_fecha_desde
   and   ct_fecha_emi <= @i_fecha_hasta
end
select @w_total         

drop table #temp 
return 0
go
