/************************************************************************/
/*  Archivo:                chqdeval.sp                                 */
/*  Stored procedure:       sp_tr_ndchqdev_loc_rem                      */
/*  Base de datos:          cob_cuentas                                 */
/*  Producto:               Cuentas Corrientes                          */
/*  Disenado por:           Pablo Mena                                  */
/*  Fecha de escritura:     5-Oct-1994                                  */
/************************************************************************/
/*                             IMPORTANTE                               */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de la           */
/*  "NCR CORPORATION".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*              PROPOSITO                                               */
/*  Este programa procesa la transaccion de nota de debito por          */
/*  cheque devuelto.(2do Proc.)                                         */
/*  2502 = Nota de debito por cheque devuelto.                          */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*  FECHA           AUTOR               RAZON                           */
/*  10/Nov/1994     G. Velasquez        Emision inicial                 */
/*  30/Nov/1998     R. Quintero         Personalizaci¢n Branch II       */
/*  06/Oct/1999     Fabricio Velasco    Resultados BRANCH II            */
/*  01/09/2003      G. Rueda            Cambio tipo @i_dpto a smallint  */
/*  03/dic/2003     C. Ruiz             agregar @i_pit                  */
/*  23/Mar/2004     O. Ligua            Manejo de cuenta interna        */
/*  03/Mar/2006     J. Colorado         Incluir re_cheque_rec otros Pro */
/*                                      ducto por requerimiento 419     */
/*  17/Mar/2006     J. Colorado         No actualizar totales por NR419 */
/*                                      Rechazos corregidos por Camara  */
/*                                      Contabilidad por Otros Ingresos */
/*  28/Mar/2007     CPA                 Manejo de transaccionalidad cuan*/
/*                                      do no cumple condicion (Branch) */
/************************************************************************/
use cob_cuentas
go

if exists (select * from sysobjects where name = 'sp_tr_ndchqdev_loc_rem')
    drop proc sp_tr_ndchqdev_loc_rem
go

create proc sp_tr_ndchqdev_loc_rem  (
    @s_ssn          int,
    @s_ssn_branch   int = null,   /*RQU Personalizaci¢n Branch II  30-Nov-1998*/ 
    @s_srv          varchar(30),
    @s_lsrv         varchar(30),
    @s_user         varchar(30),
    @s_sesn         int=null,
    @s_term         varchar(10),
    @s_date         datetime,
    @s_ofi          smallint,   /* Localidad origen transaccion */
    @s_rol          smallint,
    @s_org_err      char(1)         = null, /* Origen de error: [A], [S] */
    @s_error        int             = null,
    @s_sev          tinyint         = null,
    @s_msg          mensaje         = null,
    @s_org          char(1),
    @t_corr         char(1)         = 'N',
    @t_ssn_corr     int             = null, /* Trans a ser reversada */
    @t_debug        char(1)         = 'N',
    @t_file         varchar(14)     = null,
    @t_from         varchar(32)     = null,
    @t_rty          char(1)         = 'N',
    @t_trn          int,            
    @t_ejec         char(1)         = null, /* FVE: 06/Oct/99 resultados solo para BRANCH */
    @p_lssn         int             = null,
    @p_rssn_corr    int             = null,
    @i_ctadb        cuenta,
    @i_producto     tinyint,
    @i_bco          smallint,
    @i_ofi          smallint,
    @i_ciu          smallint,
    @i_ctachq       cuenta,
    @i_nchq         int,
    @i_valch        money,
    @i_tipchq       varchar(1),
    @i_dpto         smallint = 1,
    @i_mon          tinyint,  
    @i_cau          varchar(3),    
    @i_oficina      smallint,    
    @i_filial       smallint    = 1,   --CRO
    @i_idcaja       int         = 0,        --CRO
    @i_idcierre     int         = 0,        --CRO
    @i_sld_caja     money       = 0,      --CRO
    @i_pit          char(1)     = 'N',
    @i_num_titulo   varchar(10) = null,
    @i_titulo       char(1)     = 'N', 
    @i_rechazo      char(1)     = 'N',
    @i_rech_dev     char(1)     = null,          
    @o_sldcont      money       out,
    @o_slddisp      money       out,
    @o_nombre       varchar(30) out,
    @o_val_deb      money       out,
    @o_comision     money       out,
    @o_ind          tinyint     = null out,
    @o_oficina      smallint    = null out,
    @o_flag         float       = null out
)
as
declare @w_return           int,
        @w_sp_name          varchar(30),
        @w_cuenta           int,
        @w_filial           tinyint,
        @w_oficina          smallint,
        @w_producto         tinyint,
        @w_val_mon          money,
        @w_server_local     descripcion,
        @w_tipo             char(1),
        @w_signo            char(1),
        @w_val_deb          money,
        @w_sldcont          money,
        @w_slddisp          money,
        @w_nombre           varchar(30),
        @w_prod             varchar(30),
        @w_factor           int,
        @w_tip_prom         char(1),
        @w_estado           char(1),
        @w_comision         money,
        @w_clase_clte       char(1),
        @w_prod_banc        tinyint,
        @w_oficial          smallint, --ARV DIC/27/00
        @w_cta_interna      cuenta,             --OLI 03292004
        @w_fecha_tmp        datetime,           --OLI 03292004
        @w_cau_tmp          varchar(3),         --OLI 09292004
        @w_tnemonico        varchar(3),         --OLI 04022004
        @w_numreg           int,
        @w_otring           char(1), 
        @w_transaccion      int,
        @w_cliente          int 

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_tr_ndchqdev_loc_rem',
        @w_cta_interna = '999999999999'         --OLI 03292004

/* Modo de correccion */
if @t_corr = 'N'
    select @w_factor =  1, @w_signo = 'D'
else
    select @w_factor = -1, @w_signo = 'C'

begin tran
if @i_ctadb <> @w_cta_interna
begin
   -- Determinacion de vigencia de la cuenta 
   exec @w_return = cob_cuentas..sp_cta_vigente
   @t_debug     = @t_debug,
   @t_file      = @t_file,
   @s_ofi       = @s_ofi,
   @s_srv       = @s_srv,
   @i_ver_nodo  = 'N',
   @i_val       = @i_valch,
   @t_from      = @w_sp_name,
   @i_cta_banco = @i_ctadb,
   @i_moneda   	= @i_mon,
   @i_pit       = @i_pit,
   @o_filial    = @w_filial out,
   @o_oficina   = @w_oficina out,
   @o_cuenta    = @w_cuenta out,
   @o_tpromedio = @w_tip_prom out
   
   if @w_return != 0
      return @w_return

   select @o_oficina = @w_oficina

   --  Nota de Debito por Cheque Devuelto  
   exec @w_return = cob_cuentas..sp_nd_chq_dev  
   @t_debug         = @t_debug,
   @t_from          = @w_sp_name,
   @t_file          = @t_file,
   @t_trn           = @t_trn,
   @t_corr          = @t_corr,
   @p_lssn          = @p_lssn,
   @p_rssn_corr     = @p_rssn_corr,
   @t_rty           = @t_rty,
   @t_ejec          = @t_ejec,
   @s_ssn           = @s_ssn,
   @s_ssn_branch    = @s_ssn_branch,
   @s_ofi           = @s_ofi,
   @s_srv           = @s_srv,
   @s_rol           = @s_rol,
   @s_lsrv          = @s_lsrv,
   @s_user          = @s_user,
   @s_term          = @s_term,
   @s_org           = @s_org,
   @s_date          = @s_date, --RQU Personalizacion Branch II 1-Dic-1998
   @t_ssn_corr      = @t_ssn_corr,
   @i_producto      = @i_producto,
   @i_ctadb         = @i_ctadb,
   @i_cta_int       = @w_cuenta,
   @i_bco           = @i_bco,
   @i_ofi           = @i_ofi,
   @i_ciu           = @i_ciu,
   @i_ctachq        = @i_ctachq,
   @i_nchq          = @i_nchq,
   @i_valch         = @i_valch,
   @i_tipchq        = @i_tipchq,
   @i_dpto          = @i_dpto,
   @i_mon           = @i_mon,  
   @i_cau           = @i_cau,    
   @i_factor        = @w_factor,
   @i_fecha         = @s_date,
   @i_filial        = @w_filial,
   @i_oficina       = @w_oficina,
   @i_pit           = @i_pit,
   @i_num_titulo    = @i_num_titulo,  
   @i_rechazo       = @i_rechazo,
   @i_titulo        = @i_titulo,
   @i_rech_dev      = @i_rech_dev,        
   @o_sldcont       = @o_sldcont    out,
   @o_slddisp       = @o_slddisp    out,
   @o_nombre        = @o_nombre     out,
   @o_val_deb       = @o_val_deb    out,
   @o_ind           = @o_ind 	    out,
   @o_flag          = @o_flag 	    out,
   @o_comision      = @o_comision   out,
   @o_clase_clte    = @w_clase_clte out,
   @o_prod_banc     = @w_prod_banc  out,
   @o_cliente       = @w_cliente    out 
   
   if @w_return != 0
      return @w_return
end

if @s_org = 'S'
begin
   /* Actualizacion de Totales de cajero */
   exec @w_return = cob_remesas..sp_upd_totales
   @i_ofi            = @s_ofi,
   @i_rol            = @s_rol,
   @i_user           = @s_user,
   @i_mon            = @i_mon,
   @i_trn            = @t_trn,
   @i_nodo           = @s_srv,
   @i_tipo           = 'R',
   @i_corr           = @t_corr,
   @i_efectivo       = @i_valch,
   @i_ssn            = @s_ssn,
   @i_filial         = @i_filial,        --CRO
   @i_idcaja         = @i_idcaja,        --CRO
   @i_idcierre       = @i_idcierre,      --CRO
   @i_saldo_caja     = @i_sld_caja,      --CRO
   @i_pit            = @i_pit
   
   if @w_return != 0
   begin
      exec cobis..sp_cerror1
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 205000,
      @i_pit    = @i_pit
      return 205000
   end
    
   select @w_oficial=cc_oficial
   from cob_cuentas..cc_ctacte
   where cc_cta_banco=@i_ctadb
   
   /*  Transaccion monetaria */

   insert into cob_cuentas..cc_notcredeb
   (secuencial,      tipo_tran,       oficina,
    usuario,         terminal,        correccion,
    sec_correccion,  reentry,         origen,
    nodo,            fecha,           cta_banco, 
    signo,           val_cheque,      valor,
    remoto_ssn,      moneda,          sld_contable, 
    nro_cheque,      sld_disponible,  departamento, 
    banco,           indicador,       vcomision,
    oficina_cta,     filial,          identifi_sol,
    tmora,           oficial,         clase_clte,
    prod_banc)
    values 
    (@s_ssn,         @t_trn,          @s_ofi,
     @s_user,        @s_term,         @t_corr,
     @p_rssn_corr,   @t_rty,          'R',
     @s_srv,         @s_date,         @i_ctadb, 
     @w_signo,       @i_valch,        @o_val_deb, 
     @p_lssn,        @i_mon,          @o_sldcont, 
     @i_nchq,        @o_slddisp,      @i_dpto, 
     @i_bco,         @o_ind,          @o_comision,
     @w_oficina,     @w_filial,       @i_num_titulo, 
     @o_flag,        @w_oficial,      @w_clase_clte, 
     @w_prod_banc)
     if @@error != 0
     begin
        exec cobis..sp_cerror1
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num      = 203000,
        @i_pit      = @i_pit
        return 203000
     end
end
else
if @s_org = 'U'
begin
   if @i_rechazo = 'N'
   begin
      /* Actualizacion de Totales de cajero */
      exec @w_return = cob_remesas..sp_upd_totales
      @i_ofi            = @s_ofi,
      @i_rol            = @s_rol,
      @i_user           = @s_user,
      @i_mon            = @i_mon,
      @i_trn            = @t_trn,
      @i_nodo           = @s_srv,
      @i_tipo           = 'L',
      @i_corr           = @t_corr,
      @i_efectivo       = @i_valch,
      @i_ssn            = @s_ssn,
      @i_filial         = @i_filial,        --CRO
      @i_idcaja         = @i_idcaja,        --CRO
      @i_idcierre       = @i_idcierre,      --CRO
      @i_saldo_caja     = @i_sld_caja,      --CRO
      @i_pit            = @i_pit
      if @w_return != 0
      begin
         exec cobis..sp_cerror1
         @t_debug  = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 205000,
         @i_pit    = @i_pit
         return 205000
      end
   end 

   if @i_ctadb <> @w_cta_interna
   begin
      if @t_corr = 'S'
      begin
         select @w_estado = 'R',
                @p_rssn_corr = @t_ssn_corr
      end

      select @o_flag = round(@o_flag,0)

      /*  Transaccion monetaria */
      if not exists (select 1
                     from cob_cuentas..cc_tran_monet
                     where tm_ssn_branch  = @s_ssn_branch 
                     and   tm_oficina     = @s_ofi
                     and   tm_cod_alterno = 0)  /*RQU: PERSONALIZACION BRANCH II 10-12-98*/
      begin
         insert into cob_cuentas..cc_notcredeb
         (secuencial,     tipo_tran,      oficina,
          usuario,        terminal,       correccion,
          sec_correccion, reentry,        origen,
          nodo,           fecha,          cta_banco, 
          signo,          val_cheque,     valor, 
          ssn_branch,     moneda,         sld_contable, 
          nro_cheque,     sld_disponible, departamento, 
          banco,          indicador,      vcomision,
          oficina_cta,    filial,         identifi_sol, 
          estado,         tmora,          oficial,
          clase_clte,     prod_banc,      cliente)--ARV
         values 
         (@s_ssn,        @t_trn,         @s_ofi,
          @s_user,       @s_term,        @t_corr,
          @p_rssn_corr,  @t_rty,         'L',
          @s_srv,        @s_date,        @i_ctadb, 
          @w_signo,      @i_valch,       @o_val_deb,
          @s_ssn_branch, @i_mon,         @o_sldcont, 
          @i_nchq,       @o_slddisp,     @i_dpto, 
          @i_bco,        @o_ind,         @w_comision,
          @w_oficina,    @w_filial,      @i_num_titulo,  
          @w_estado,     @o_flag,        @w_oficial, 
          @w_clase_clte, @w_prod_banc,   @w_cliente)
          
         if @@error != 0
         begin
            exec cobis..sp_cerror1
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 203000,
            @i_pit      = @i_pit
            return 203000
         end
      end
      else
      begin
         exec cobis..sp_cerror1
         @t_debug   = @t_debug,
         @t_file    = @t_file,
         @t_from    = @w_sp_name,
         @i_num     = 201200,
         @i_pit     = @i_pit
         return 201200
      end

      if @t_corr = 'S'
      begin
         if not exists (select 1
                        from  cob_cuentas..cc_tran_monet
                        where tm_ssn_branch  = @t_ssn_corr  /*RQU: Personalizaci›n Branch II 10-12-98*/
                        and   tm_cod_alterno = 0
                        and   tm_oficina     = @s_ofi
                        and   tm_cta_banco   = @i_ctadb
                        and   tm_efectivo    = @i_valch
                        and   tm_moneda      = @i_mon
                        and   tm_usuario     = @s_user
                        and   tm_estado      is null
                        and   tm_tipo_tran   = @t_trn)
      
         begin
            /* No encontrs el registro en monetarias */
            exec cobis..sp_cerror1
            @t_debug     = @t_debug,
            @t_file      = @t_file,
            @t_from      = @w_sp_name,
            @i_num       = 251067,
            @i_pit       = @i_pit
            return 251067
         end
      
         update cob_cuentas..cc_tran_monet set
         tm_estado = @w_estado
         where tm_ssn_branch = @t_ssn_corr  /*RQU: Personalizaci›n Branch II 30-Nov-98*/
         and   tm_oficina = @s_ofi  /*RQU: Personalizaci›n Branch II 30-Nov-98*/
         and   tm_cod_alterno = 0
      
         if @@rowcount <> 1
         begin
            /* Error en actualizacion de registro en cc_tran_mo */
            exec cobis..sp_cerror1
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_num     = 251067,
            @i_pit     = @i_pit
            return 251067
         end
      end
   end      --END Cuentas Normales
   else
   begin    /* OLI 03292004. Devolucion Cuenta Interna - 999999999999 */
      if @t_corr = 'S'
         select 
         @w_estado    = 'R',
         @w_signo     = 'I',
         @w_fecha_tmp = null,
         @w_cau_tmp   = null
      else
         select 
         @w_estado    = 'N',
         @w_signo     = 'D',
         @w_fecha_tmp = @s_date,
         @w_cau_tmp   = @i_cau

    if @t_corr = 'N'
    begin 
       select @w_tnemonico = convert(varchar(3),cd_departamento),
              @w_otring    = isnull(cd_otring, 'N'),
              @w_cliente   = isnull(cd_cliente, 0)
       from   cob_cuentas..cc_chq_otrdept
       where  cd_banco_chq = @i_bco
       and    cd_cta_chq   = @i_ctachq
       and    cd_num_chq   = @i_nchq
       and    cd_valor     = @i_valch
       and    cd_fecha_ope = null 


       if @@rowcount = 0
       begin
          /* No existe Cheque de Otros Productos */
          exec cobis..sp_cerror1
          @t_debug    = @t_debug,
          @t_file     = @t_file,
          @t_from     = @w_sp_name,
          @i_num      = 201188,
          @i_pit      = @i_pit
          return 201188
       end
   end
   else
   begin
        select 
        @w_tnemonico = convert(varchar(3),cd_departamento),
        @w_otring    = isnull(cd_otring, 'N'),
        @w_cliente   = isnull(cd_cliente, 0)
        from  cob_cuentas..cc_chq_otrdept
        where cd_banco_chq = @i_bco
        and   cd_cta_chq   = @i_ctachq
        and   cd_num_chq   = @i_nchq
        and   cd_valor     = @i_valch
        and   cd_fecha_ope = @s_date

        if @@rowcount = 0
        begin
           /* No existe Cheque de Otros Productos */
           exec cobis..sp_cerror1
           @t_debug    = @t_debug,
           @t_file     = @t_file,
           @t_from     = @w_sp_name,
           @i_num      = 201188,
           @i_pit      = @i_pit
           return 201188
        end
   end 

   update cob_cuentas..cc_chq_otrdept set
   cd_estado          = @w_signo,
   cd_fecha_ope       = @w_fecha_tmp,
   cd_causadev        = @w_cau_tmp
   where cd_banco_chq = @i_bco
   and cd_cta_chq     = @i_ctachq
   and cd_num_chq     = @i_nchq
   and cd_valor       = @i_valch

   if @@error <> 0
   begin
      /* Error en actualizacion de cheque otros productos */
      exec cobis..sp_cerror1
      @t_debug      = @t_debug,
      @t_file       = @t_file,
      @t_from       = @w_sp_name,
      @i_num        = 205044,
      @i_pit        = @i_pit
      return 205044
   end

   if  @w_otring  = 'S' 
       select @w_transaccion =  2908
   else
       select @w_transaccion = @t_trn

   /* Insercion de transaccion de servicio para contabilizacion */
   insert cob_cuentas..cc_tran_servicio
   (ts_secuencial,  ts_tipo_transaccion, ts_oficina,    ts_usuario,   ts_terminal,  
    ts_tsfecha,     ts_cta_banco,        ts_ctacte,     ts_valor,     ts_cheque,   
    ts_moneda,      ts_oficina_cta,      ts_clase_clte, ts_prod_banc, ts_producto,
    ts_estado,      ts_correccion,       ts_ssn_branch, ts_cta_gir,   ts_ssn_corr,
    ts_referencia,  ts_causa,            ts_cliente)
   values
   (@s_ssn,         @w_transaccion,      @s_ofi,        @s_user,      @s_term,
    @s_date,        @w_cta_interna,      0,             @i_valch,     @i_nchq,
    @i_mon,         @s_ofi,              'P',           1,            3,
    @w_estado,      @t_corr,             @s_ssn_branch, @i_ctachq,    @t_ssn_corr,
    @i_cau,         @w_tnemonico,        @w_cliente)
   if @@error <> 0
   begin
      /* Error en actualizacion de cheque otros productos */
      exec cobis..sp_cerror1
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @w_sp_name,
           @i_num        = 203005,
           @i_pit        = @i_pit
      return 203005
   end

   if @t_corr = 'N' and @i_rechazo = 'N'
   begin
     /* Incluir re_cheque_rec */
     /* Insert en tabla re_cheque_rec */
     exec @w_return = cobis..sp_cseqnos
     @t_debug      = @t_debug,
     @t_file       = @t_file,
     @t_from       = @w_sp_name, 
     @i_tabla      = 're_cheque_rec',
     @o_siguiente  = @w_numreg out

     if @w_return != 0
        return @w_return

     insert into cob_remesas..re_cheque_rec
     (cr_cheque_rec, cr_fecha_ing,  cr_status,         cr_cta_depositada,
      cr_valor,      cr_banco_p,    cr_oficina_p,      cr_ciudad_p,
      cr_cta_girada, cr_num_cheque, cr_oficina,        cr_procedencia,
      cr_producto,   cr_moneda,     cr_cau_devolucion, cr_tipo_cheque,
      cr_estado,     cr_num_titulo)
     values  
     (@w_numreg,     @s_date,       'D',               -1, 
      @i_valch,      @i_bco,        @s_ofi,            @i_ciu,
      @i_ctachq,     @i_nchq,       @s_ofi,            'V',
      @i_producto,   @i_mon,        @i_cau,            @i_tipchq,
      'P',           @i_num_titulo)

      if @@error != 0
      begin
         exec cobis..sp_cerror1
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @w_sp_name,
         @i_num          = 203000,
         @i_pit          = @i_pit
         return 203000
      end
   end
   
   if @t_corr = 'S'
   begin
      update cob_cuentas..cc_tran_servicio set
      ts_estado   = @w_estado
      where ts_ssn_branch = @t_ssn_corr
      and   ts_oficina    = @s_ofi
      and   ts_usuario    = @s_user
      and   ts_moneda     = @i_mon
      and   ts_cta_gir    = @i_ctachq
      and   ts_cheque     = @i_nchq
      and   ts_valor      = @i_valch
      and   ts_cta_banco  = @w_cta_interna
      and   ts_referencia = @i_cau
      and   ts_estado     = 'N'
      if @@rowcount <> 1 or @@error <> 0
      begin
         /* Transaccion origen del reverso no coincide */
         exec cobis..sp_cerror1
              @t_debug      = @t_debug,
              @t_file       = @t_file,
              @t_from       = @w_sp_name,
              @i_num        = 251067,
              @i_pit        = @i_pit
         return 251067
      end
   
      if @i_rechazo = 'N'
      begin
         delete cob_remesas..re_cheque_rec
         where  cr_fecha_ing      = @s_date
         and    cr_valor          = @i_valch
         and    cr_oficina        = @s_ofi
         and    cr_num_cheque     = @i_nchq
         and    cr_cta_depositada = -1
         and    cr_producto       = @i_producto
         and    cr_banco_p        = @i_bco
        
         if @@error != 0
         begin
            exec cobis..sp_cerror1
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 203000,
            @i_pit      = @i_pit
            return 203000
         end
      end 
   end
end

select 'Nombre' = @w_oficina
end
commit tran
return 0
go
