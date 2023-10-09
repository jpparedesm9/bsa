/* ***********************************************************************/
/*      Archivo:                sp_usuario_hsbc.sp                          */
/*      Stored procedure:       sp_usuario_hsbc                          */
/*      Base de datos:          cobis                                   */
/*      Producto: Administracion                                        */
/*      Disenado por:  Javier Calderon/Javier Garcia                    */
/*      Fecha de escritura: 01-Jun-2012                                 */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de:                     */
/*                        MODIFICACIONES                                */
/*      FECHA           AUTOR           RAZON                           */
/*      01/Junio/2012   Javier Calderon       Emision inicial           */
/*      24/Oct/2012     Mario Velez     Se aplica Validaciones para M&C */
/*      24/Jun/2016     J.Hernandez     Ajuste Vesion Falabella cambio  */
/*                                      tipo de   dato nodo             */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_usuario_hsbc')
   drop proc sp_usuario_hsbc
go

create proc sp_usuario_hsbc (
   @s_ssn                  int = NULL,
   @s_user                 login = NULL,
   @s_sesn                 int = NULL,
   @s_term                 varchar(32) = NULL,
   @s_date                 datetime = NULL,
   @s_srv                  varchar(30) = NULL,
   @s_lsrv                 varchar(30) = NULL, 
   @s_rol                  smallint = NULL,
   @s_ofi                  smallint = NULL,
   @s_org_err              char(1) = NULL,
   @s_error                int = NULL,
   @s_sev                  tinyint = NULL,
   @s_msg                  descripcion = NULL,
   @s_org                  char(1) = NULL,
   @t_debug                char(1) = 'N',
   @t_file                 varchar(14) = null,
   @t_from                 varchar(32) = null,
   @t_trn                  smallint =NULL,
   @t_offset      varbinary(32) =NULL, -- ARO:18/01/2001   CRYPWD
   @t_tampwd      int =NULL,     -- ARO:18/01/2001   CRYPWD
   @t_ejec        char(1) = NULL,      -- ADU:2003-01-02   Reejecución del password
   @t_show_version         bit  = 0,
        @mc_validacion          int = 0,                -- Mario Velez, 14/Sep/2012, Para Validaciones de M&C
   @i_operacion            char(1),
   @i_tipo                 char(1) = null,
   @i_modo                 smallint = null,
   @i_filial               tinyint = null,
   @i_oficina              smallint = null,
   @i_nodo                 smallint = null,
   @i_login                varchar(30) = NULL,
   @i_creador              smallint = NULL,
   @i_clave                varchar(30) = NULL,
   @i_fecha_asig           datetime = NULL,
        @i_estado               varchar(1) = 'V',
   @i_funcionario          smallint = NULL, /* PES 1999/09/02 */
   @i_flag        char(1) = 'S',  /* PES 2000/06/06 */
        @i_central_transmit     varchar(1) = null,
   @i_formato_fecha  int=null
)
as
declare
   @w_sp_name              varchar(32),
   @w_today                datetime,
   @w_fecha_asig           datetime,
   @w_filial               tinyint,
   @w_oficina              smallint,
   @w_nodo                 smallint,
   @w_creador              smallint,
   @w_login                varchar(24),
   @w_clave                varchar(30),
   @v_fecha_asig           datetime,
   @v_filial               tinyint,
   @v_oficina              smallint,
   @v_nodo                 smallint,
   @v_creador              smallint,
   @v_login                varchar(24),
   @v_clave                varchar(30),
   @o_fecha_asig           datetime,
   @o_funcionario          smallint, /* PES 1999/09/02 */
   @o_nombre_fun           descripcion,
   @o_filial               tinyint,
   @o_oficina              smallint,
   @o_nodo                 smallint,
   @o_nombre_f             descripcion,
   @o_nombre_o             descripcion,
   @o_nombre_n             descripcion,
   @o_creador              smallint,
   @o_login                varchar(24),
   @o_clave                varchar(30),
   @w_siguiente            int,
   @w_fecha_ult_mod        datetime,
   @v_fecha_ult_mod        datetime,
   @o_nombre_crea          descripcion,
   @o_estado      varchar(1),
   @w_return               int,
   @w_cmdtransrv           varchar(64),
        @w_clave_re             int,
        @w_nt_nombre            varchar(32),
        @w_num_nodos            smallint,
        @w_contador             smallint,
        @w_tp        tinyint,
        @w_tmp       tinyint,
        @w_npch         tinyint,
        @w_clave_his    varchar(30),
         @w_offset_his     varbinary(32), -- ARO:19/01/2001
        @w_contador_his    int,
        @w_sec_his      int,
        @w_pwd       char(1),    -- ADU:25-08-2004
       @w_dvpw          smallint          --SCA

/*****MC Mario Velez, 24/Oct/2012*****/
if @mc_validacion = 1
  begin 
      return 0
  end
/*****MC*****/

select @w_today = convert(datetime, convert(varchar(10), getdate(), 101))
select @w_sp_name = 'sp_usuario_hsbc'

------------------------------------------
---VERSIONAMIENTO PROGRAMA-----------------
-------------------------------------------
if @t_show_version = 1 
begin
      print 'Stored procedure sp_cons_ofic_hsbc, version 1.0.0.0'
      return 0
END


/* ** help  funcionario** */
if @i_operacion = 'F'
BEGIN

 if @i_tipo = 'A'
 begin
    set rowcount 20
    ------------------
    if @i_modo = 0
    begin
    select   'Codigo' = fu_funcionario,
        'Nombre'  = fu_nombre,
        'Login'  = fu_login,
        'Departamento'= fu_departamento
      from   cl_funcionario
      order  by fu_funcionario
    end
    -------------
    if @i_modo = 1
    begin
    select   'Codigo' = fu_funcionario,
        'Nombre'  = fu_nombre,
        'Login'  = fu_login,
        'Departamento'= fu_departamento
      from   cl_funcionario
      where  fu_funcionario > @i_funcionario
      order  by fu_funcionario
    END
    
    --------------
    set rowcount 0
  END
 
 if @i_tipo = 'V'
 begin
    select   fu_nombre, fu_login, fu_departamento
      from   cl_funcionario
     where   fu_funcionario = @i_funcionario
   
   if @@rowcount = 0
   begin
         exec sp_cerror
         @t_debug     = @t_debug,
         @t_file      = @t_file,
         @t_from      = @w_sp_name,
         @i_num       = 101036
         
         return 1
   END
   
   
 END
 
 
END



GO

