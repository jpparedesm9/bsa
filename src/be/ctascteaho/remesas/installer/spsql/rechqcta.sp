/************************************************************************/
/*  Archivo:            rechqcta.sp                                     */
/*  Stored procedure:   sp_rem_chequexcta                               */
/*  Base de datos:      cob_remesas                                     */
/*  Producto:           Remesas                                         */
/*  Disenado por:       Julio Navarrete                                 */
/*  Fecha de escritura: 07-May-1993                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de la           */
/*  "NCR CORPORATION".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Este programa procesa la consulta de cheques de remesas por         */
/*      cuenta tanto en corrientes como en Ahorros                      */ 
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA           AUTOR           RAZON                               */
/*  07/May/1993     J Navarrete     Emision inicial                     */
/*  12/Ene/1995     J. Bucheli      Personalizacion para Banco de       */
/*                                  la Produccion                       */
/*  19/Jun/1995     D. Villafuerte  Personaqizacion Bco. Prestamos      */
/*  23/Ene/1996     D. Villafuerte  Cajero Interno                      */
/*  21/Sep/1999     V. Molina E.    Banco del Caribe                    */
/*  21/Ago/2003     S.Molano        Adicion Columna de O.Destino        */
/************************************************************************/

use cob_remesas
go

set ansi_nulls off
go

if exists (select * from sysobjects where name = 'sp_rem_chequexcta')
    drop proc sp_rem_chequexcta




go
create proc sp_rem_chequexcta (
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
    @p_lssn         int = null,
    @p_rssn         int = null,
    @p_rssn_corr    int = null,
    @p_envio        char(1) = 'N',
    @p_rpta         char(1) = 'N',
    @i_cta          cuenta,
    @i_mon          tinyint,
    @i_tiporem      char(1) = 'T',
    @i_ultimo       int = 0, 
    @i_carta        int = 0,
    @i_finesse      char(1) = 'N'
)
as
declare @w_return   int,
    @w_sp_name  varchar(30),
    @w_cta      cuenta,
    @w_ctadep   int,
    @w_producto tinyint,
    @w_total    money,  
    @w_nombre   char(60)

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_rem_chequexcta'

/* Chequeo de errores generados remotamente */
if @s_org_err is not null           /*  Error del Sistema  */
begin
   exec cobis..sp_cerror
   @t_from         = @w_sp_name,
   @i_num          = @s_error,
   @i_sev          = @s_sev,
   @i_msg          = @s_msg
   return 1
end

/* Cuenta de Cajero Interno */
if @i_cta = '9999999999'
   select @w_ctadep = -1
else
begin  
   select 
   @w_ctadep = cc_ctacte,
   @w_nombre = cc_nombre
   from  cob_cuentas..cc_ctacte
   where cc_cta_banco = @i_cta

   if @@rowcount = 0
   begin 
      select 
      @w_ctadep = ah_cuenta,
      @w_nombre = ah_nombre
      from cob_ahorros..ah_cuenta
      where ah_cta_banco = @i_cta

      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_from         = @w_sp_name,
         @i_num          = 351012
         return 1
      end
   end
end

if @i_tiporem = 'T'
begin
   set rowcount 20 

   select 
   'FECHA ING.  ' = convert(char(10),cr_fecha_ing,101),
   'OF. ORIGEN  ' = cr_oficina,
   --'OF. DESTINO ' = cr_oficina_p,
   'OF. DESTINO ' = ct_oficina_c,
   'BCO. GIRADOR' = cr_banco_p,
   'CTA. GIRADA ' = cr_cta_girada,
   'CARTA'        = ct_carta,
   'DIAS  '       = datediff (dd, dc_fecha_emi, dc_fecha_efe) + 1,
   'CHEQUE'       = cr_num_cheque,
   'No. REM'      = cr_cheque_rec,
   'VALOR '       = cr_valor,
   'ESTADO'       = substring(c.valor,1,25),
   'SUB-ESTADO' = a.valor,
   'FECHA EFEC.'  = convert(char(10),dc_fecha_efe,101),
   'TIPO'        = dc_tipo_rem
    from cob_remesas..re_cheque_rec,
          cob_remesas..re_carta,
          cobis..cl_catalogo c,
          cobis..cl_catalogo a
    right outer join cob_remesas..re_det_carta 
     on a.codigo = dc_sub_estado     
   where cr_cta_depositada  = @w_ctadep
   and ((dc_carta = @i_carta and cr_cheque_rec > @i_ultimo)
    or   dc_carta > @i_carta)
   and cr_moneda      = @i_mon
   and dc_cta_depositada = @i_cta
   and ct_carta       = dc_carta
   and cr_cheque_rec  = dc_cheque
   and c.tabla = (select cobis..cl_tabla.codigo
                  from cobis..cl_tabla
                  where tabla = 're_tcheque')
   and c.codigo = dc_status  --cr_status
   and a.tabla = (select codigo from cobis..cl_tabla where tabla ='re_sub_estado')
   order by dc_carta, cr_cheque_rec
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_from         = @w_sp_name,
      @i_num          = 351045
      return 351045
   end
                            
   set rowcount 0 
   select @w_total = sum(dc_valor)
   from  cob_remesas..re_det_carta
   where dc_cta_depositada = @i_cta
   and   dc_moneda = 0
end 
else
begin
   set rowcount 20 
   select 
   'FECHA ING.  ' = convert(char(10),cr_fecha_ing,101),
   'OF. ORIGEN  ' = cr_oficina,
   --'OF. DESTINO ' = cr_oficina_p,
   'OF. DESTINO ' = ct_oficina_c,
   'BCO. GIRADOR' = cr_banco_p,
   'CTA. GIRADA ' = cr_cta_girada,
   'CARTA'        = ct_carta,
   'DIAS  '       = datediff (dd, dc_fecha_emi, dc_fecha_efe) + 1,
   'CHEQUE'       = cr_num_cheque,
   'No. REM'      = cr_cheque_rec,
   'VALOR '       = cr_valor,
   'ESTADO'       = substring(c.valor,1,25),
   'SUB-ESTADO'   = a.valor,
   'FECHA EFEC.'  = convert(char(10),dc_fecha_efe,101),
   'TIPO'         = dc_tipo_rem
   from cob_remesas..re_cheque_rec,
        cob_remesas..re_carta,
        cobis..cl_catalogo c,
        cobis..cl_catalogo a
    right outer join cob_remesas..re_det_carta  
     on a.codigo = dc_sub_estado
   where cr_cta_depositada  = @w_ctadep
   and ((dc_carta = @i_carta and cr_cheque_rec > @i_ultimo)
    or   dc_carta > @i_carta)
   and cr_moneda  = @i_mon
   and dc_cta_depositada = @i_cta
   and ct_carta   = dc_carta
   and cr_cheque_rec = dc_cheque
   and c.tabla = (select cobis..cl_tabla.codigo
                  from cobis..cl_tabla
                 where tabla = 're_tcheque')
   and c.codigo =  dc_status  --cr_status
   and dc_status = @i_tiporem --cr_status     = @i_tiporem 
   and a.tabla = (select codigo from cobis..cl_tabla where tabla ='re_sub_estado')
   order by dc_carta, cr_cheque_rec

   set rowcount 0
   
   select @w_total = sum(dc_valor)
   from  cob_remesas..re_det_carta
   where dc_cta_depositada = @i_cta
   and   dc_moneda = 0
   and   dc_status = @i_tiporem 
end
select @w_total         
return 0
go
