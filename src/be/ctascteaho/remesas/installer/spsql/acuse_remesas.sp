/****************************************************************************/
/*     Archivo:          acuse_remesas.sp                                   */
/*     Stored procedure: sp_acuse_remesas                                   */
/*     Base de datos:    cob_remesas                                        */
/*     Producto:         Ahorros                                            */
/*     Disenado por:     Karen Meza                                         */
/*     Fecha de escritura: 29/06/2016                                       */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*                                                                          */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     29/06/2016     Karen Meza      Migracion a CEN                        */
/****************************************************************************/
use cob_remesas
go



if exists (select * from sysobjects where name = 'sp_acuse_remesas')
        drop proc sp_acuse_remesas
go
create proc sp_acuse_remesas (
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
    @i_corres       char(12),
    @i_propie       char(12),
    @i_fecha        smalldatetime,
    @i_secuen       int,
    @i_hablt        char(1),
    @i_mon          tinyint,
    @i_acuse        char(1)
)
as
declare @w_return   int,
    @w_sp_name      varchar(30),
    @w_mensaje      varchar(120),
    @w_filial       tinyint,
    @w_fecha        varchar(10),
    @w_fecha_efe    smalldatetime,
    @w_fecha_efe1   smalldatetime,
    @w_fecha_aux    smalldatetime,
    @w_oficina      smallint,
    @w_ofi_bco      smallint,
    @w_tipo         char(1),
    @w_dias_anio    smallint,
    @w_carta        int,
    @w_valor        money,
    @w_bco_p        smallint,
    @w_ofi_p        smallint,
    @w_par_p        int,
    @w_bco_c        smallint,
    @w_ofi_c        smallint,
    @w_par_c        int,
    @w_oficial      smallint,
    @w_cheque       int,
    @w_cheque1      int,
    @w_val          money,
    @w_factor       int,
    @w_cont         smallint,
    @w_num_cheque   int,
    @w_ciudad       int,
    @w_ciudad_rem   int,
    @w_bco          smallint,
    @w_ofi          smallint,
    @w_par          int,
    @w_tipo_rem     char(1)

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_acuse_remesas'

/* Validacion de la transaccion */
if @t_trn != 603
begin
   /* Error en numero de transaccion */
   exec cobis..sp_cerror
   @t_from         = @w_sp_name,
   @i_num          = 201048
   return 1
end

/* Encuentra la ciudad de la oficina */
select @w_ciudad = of_ciudad
  from cobis..cl_oficina
 where of_oficina = @s_ofi

select @w_ciudad_rem = ci_cod_remesas
  from cobis..cl_ciudad
 where ci_ciudad = @w_ciudad

if @@rowcount <> 1
begin
   /* Error: no existe codigo de ciudad remesa */
   exec cobis..sp_cerror
   @t_from      = @w_sp_name,
   @i_num       = 201159
   return 1
end

/* Separa codigo de banco del cheque en sus componentes */
select @w_bco = convert(smallint, substring(@i_corres,1,4))
select @w_ofi = convert(smallint, substring(@i_corres,5,4))
select @w_par = convert(int, substring(@i_corres,9,4))

/* Valida datos */
if @i_secuen = 0
begin
   exec cobis..sp_cerror
   @t_from     = @w_sp_name,
   @i_num      = 351002
   return 1
end

/*Seleciona los dias en la tabala re_transito*/

/* Encuentra banco corresponsal dado el codigo de banco del cheque */
select @w_dias_anio = tn_num_dias
from  cob_remesas..re_transito
where tn_banco_c   = @w_bco
and   tn_oficina_c = @w_ofi 
and   tn_ciudad_c  = @w_par
if @@rowcount = 0
begin
   exec cobis..sp_cerror
   @t_from         = @w_sp_name,
   @i_num          = 351001
   return 1
end
    
/* Encuentra la fecha de efectivizacion de la carta */
if @w_dias_anio > 0
begin
   select @w_fecha_aux = @s_date,
          @w_cont = 1
   select @w_fecha_aux = dateadd(dd, 1, @w_fecha_aux)
   while  @w_cont <= (@w_dias_anio - 1)
   begin   
      if exists (select df_fecha
                 from  cobis..cl_dias_feriados
                 where df_ciudad = @w_ciudad
                 and   df_fecha = @w_fecha_aux)
         select @w_fecha_aux = dateadd(dd, 1, @w_fecha_aux)
      else
         select @w_fecha_aux = dateadd(dd, 1, @w_fecha_aux),
                @w_cont = @w_cont + 1

   end
   select @w_fecha_aux = dateadd(dd, -1, @w_fecha_aux)
   select @w_fecha = convert(varchar(10),@w_fecha_aux,101)
end
else
    select @w_fecha_aux = null

select  
@w_val      = ct_valor,
@w_tipo_rem = ct_tipo_rem
from  cob_remesas..re_carta
where ct_carta      =  @i_secuen

begin tran

/* Actualiza el campo re_carta*/    
update cob_remesas..re_carta
set    ct_fecha_efe  = @w_fecha_aux,
       ct_estado     = 'A'
where  ct_carta      =  @i_secuen

if @w_fecha_aux is not null
begin
   /* Cursor para re_det_carta */
   declare Acusa_carta_rem cursor
   for select  
   dc_cheque,
   dc_fecha_efe
   from  cob_remesas..re_det_carta
   where dc_carta = @i_secuen
   for update of dc_fecha_efe

   open Acusa_carta_rem

   fetch Acusa_carta_rem into
   @w_cheque,        
   @w_fecha_efe
    
   while @@fetch_status = 0
   begin         
      update cob_remesas..re_det_carta
      set dc_fecha_efe = @w_fecha_aux
      WHERE CURRENT OF Acusa_carta_rem

      if @@rowcount != 1
      begin
         close Acusa_carta_rem
         deallocate Acusa_carta_rem
      
         exec cobis..sp_cerror
         @t_from         = @w_sp_name,
         @i_num          = 355031
         return 355031
      end

      update cob_remesas..re_cheque_rec 
      set    cr_fecha_efe  = @w_fecha_aux
      where  cr_cheque_rec =  @w_cheque

      if @@rowcount != 1
      begin
         close Acusa_carta_rem
         deallocate Acusa_carta_rem
         
         exec cobis..sp_cerror
         @t_from         = @w_sp_name,
         @i_num          = 355000
         return 355000
      end

      fetch Acusa_carta_rem into
      @w_cheque,
      @w_fecha_efe
   end
end

close Acusa_carta_rem
deallocate Acusa_carta_rem

insert into cob_cuentas..cc_tran_servicio ( 
    ts_secuencial, ts_tipo_transaccion, ts_tsfecha,
    ts_usuario, ts_terminal, ts_nodo, 
    ts_oficina, ts_descripcion_ec, ts_valor,
    ts_carta, ts_banco, ts_tipo,ts_oficina_cta)
 values (@s_ssn, @t_trn, @s_date, 
    @s_user, @s_term, @s_srv, 
    @s_ofi, 'ACUSE DE CARTA REMESA', @w_val, 
    @i_secuen, @w_bco_c, @w_tipo_rem,@s_ofi) 

if @@error != 0
begin
   /* Error en creacion de transaccion de servicio */
   exec cobis..sp_cerror
   @t_from  = @w_sp_name,
   @i_num   = 203005
   return 203005
end 

select @w_fecha 

commit tran
return 0



GO

