/************************************************************************/
/*    Archivo:              cianoruc.sp                                 */
/*    Stored procedure:     sp_compania_no_ruc                          */
/*    Base de datos:        cobis                                       */
/*    Producto:             Clientes                                    */
/*    Disenado por:         Sandra Ortiz                                */
/*    Fecha de escritura:   08/14/1994                                  */
/************************************************************************/
/*                IMPORTANTE                                            */
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
/*                PROPOSITO                                             */
/*    Este stored procedure inserta companias con datos incompletos     */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*    FECHA        AUTOR            RAZON                               */
/*    08/14/1994   Peter Espinosa    Emision inicial                    */
/*    23/01/1997   J. Loyo           INsercion Tipo y numero del        */
/*                                   Documento  INTIP                   */
/*    26/Ago/1997  N.Velasco         Actualizacion ejecutivo de cuenta  */
/*                                   Personalizacion Banco del Estado   */
/*    06/May/1998  J. Loyo           Insercion de Oficial   INOFI       */
/*    14/May/1998  N. Velasco        NVR02:Cambio de tipo de Vble ente  */
/*                                   para devolver datos a FrontEnd en  */
/*                                   creacion rapida CLiente Juridico   */
/*    18/Sep/2001  E. Laguna         Parametro de Oficial - Val Banca   */
/*    05/Nov/2002  D. Dur n          Campo regimen Fiscal               */
/*    04/Feb/2005  D. Duran          Adiciono Transaccion Servicio      */
/*    04/Jul/2006  Martha Gil V.     Adicion dato en campo en_tipo_dp   */
/*    16/Jun/2007  E. Laguna         Desarrollo NR702                   */
/*    02/May/2016  DFu               Migracion CEN                      */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_compania_no_ruc')
  drop proc sp_compania_no_ruc
go

create proc sp_compania_no_ruc
(
  @s_ssn            int,
  @s_user           login,
  @s_term           varchar (30),
  @s_date           datetime,
  @s_srv            varchar(30),
  @s_lsrv           varchar(30) = null,
  @s_ofi            smallint = null,
  @t_debug          char(1) ='N',
  @t_file           varchar(14) = null,
  @t_from           descripcion = null,
  @t_trn            smallint,
  @t_show_version   bit = 0,
  @i_operacion      char (1),
  @i_nombre         descripcion,
  @i_filial         tinyint,
  @i_tipo_nit       char (2),
  @i_oficina        smallint,
  @i_ruc            numero = null,
  @i_oficial        smallint = null,
  @i_regimen_fiscal catalogo = null,/* DDU */
  @i_cod_central    varchar(10) = null,
  @i_doc_validado   char(1) = null,
  @o_ente           int = null out,
  @o_tip_ente       int = null out
)
as
  declare
    @w_sp_name       descripcion,
    @w_return        int,
    @w_ente          int,
    @w_subtipo       char (1),
    @w_fecha_mod     datetime,
    @w_fecha         datetime,
    @w_pais          smallint,
    /* REC Variables para uso de Valores por defecto */
    @w_actividad     char(10),
    @w_sectoreco     char(10),
    @w_tipo_compania char(10),
    @w_ciudad        int,
    @w_tip_soc       char(10),
    @w_oficial       smallint,
    @w_referido      smallint

/*******/
  /*  Inicializar nombre del stored procedure  */
  select
    @w_sp_name = 'sp_compania_no_ruc'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha = getdate()

  select
    @w_referido = fu_funcionario
  from   cobis..cl_funcionario
  where  fu_login = @s_user

  /* ** Insert ** */
  if @i_operacion = 'I'
  begin
    if @t_trn != 1240
    begin
      /* Codigo de transaccion invalido */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101147
      return 1
    end

    if @i_tipo_nit is null
        or @i_ruc is null
    begin
      print
  'Numero de Identificacion o Tipo de Identificacion con valores nulos'
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 601001
      return 1
    end

    if exists (select
                 *
               from   cl_ente
               where  en_subtipo  = 'C'
                  and en_tipo_ced = @i_tipo_nit
                  and en_ced_ruc  = @i_ruc)
    begin
      /****** Ente ya existe ********/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101192
      return 1
    end

  /****************************INOFI********************************/
    /* Verificar que exista el oficial indicado */

    if @i_oficial is not null
    begin
      /*   select @w_ente = fu_funcionario
           from cl_funcionario
          where fu_funcionario = @i_oficial*/

      select
        @w_ente = oc_oficial
      from   cc_oficial
      where  oc_oficial = @i_oficial

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101036
        /* 'No existe oficial'*/
        return 1
      end

      select
        @w_oficial = @i_oficial

    end
    else --end /*se toma el oficial default */
    begin
      select
        @w_oficial = pa_smallint
      from   cl_parametro
      where  pa_nemonico = 'OPD'
         and pa_producto = 'MIS'

    end

    select
      @w_fecha_mod = getdate(),
      @w_pais = pa_pais
    from   cl_tabla x,
           cl_default y,
           cl_pais
    where  x.tabla   = 'cl_pais'
       and x.codigo  = y.tabla
       and y.oficina = @s_ofi
       and y.srv     = @s_lsrv
       and y.codigo  = convert(char(10), pa_pais)

    /***REC Adicion para consulta de Valores por defecto ***/
    select
      @w_actividad = d.codigo
    from   cl_tabla t,
           cl_default d
    where  t.tabla   = 'cl_actividad'
       and t.codigo  = d.tabla
       and d.oficina = @s_ofi
       and d.srv     = @s_lsrv

    if @@rowcount = 0
    begin
      print 'NO EXISTE DEFAULT PARA ACTIVIDAD ECONOMICA'
      return 1
    end

    select
      @w_tipo_compania = d.codigo
    from   cl_tabla t,
           cl_default d
    where  t.tabla   = 'cl_nat_jur'
       and t.codigo  = d.tabla
       and d.oficina = @s_ofi
       and d.srv     = @s_lsrv

    if @@rowcount = 0
    begin
      print 'NO EXISTE DEFAULT PARA NATURALEZA JURIDICA'
      return 1
    end

    select
      @w_sectoreco = d.codigo
    from   cl_tabla t,
           cl_default d
    where  t.tabla   = 'cl_sectoreco'
       and t.codigo  = d.tabla
       and d.oficina = @s_ofi
       and d.srv     = @s_lsrv

    if @@rowcount = 0
    begin
      print 'NO EXISTE DEFAULT PARA SECTOR ECONOMICO'
      return 1
    end

    select
      @w_tip_soc = d.codigo
    from   cl_tabla t,
           cl_default d
    where  t.tabla   = 'cl_tip_soc'
       and t.codigo  = d.tabla
       and d.oficina = @s_ofi
       and d.srv     = @s_lsrv

    if @@rowcount = 0
    begin
      print 'NO EXISTE DEFAULT PARA TIPO DE SOCIEDAD'
      return 1
    end

    select
      @w_ciudad = convert(int, d.codigo)
    from   cl_tabla t,
           cl_default d
    where  t.tabla   = 'cl_ciudad'
       and t.codigo  = d.tabla
       and d.oficina = @s_ofi
       and d.srv     = @s_lsrv

    if @@rowcount = 0
    begin
      print 'NO EXISTE DEFAULT PARA CIUDAD'
      return 1
    end
    /*****Fin Validaciones por defecto ****/

    begin tran
    /******************IDENULL********************************/
    if @i_tipo_nit = 'EJ'
       and @i_ruc is null
    begin
      exec sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_documento',
        @o_siguiente = @o_tip_ente out
      select
        @i_ruc = convert(varchar(30), @o_tip_ente)
    end
    /******************IDENULL********************************/

    exec sp_cseqnos
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_tabla     = 'cl_ente',
      @o_siguiente = @o_ente out

    /* insertar los parametros de entrada */
    insert into cl_ente
                (en_ente,en_subtipo,en_nombre,en_actividad,c_posicion,
                 en_ced_ruc,en_grupo,c_activo,c_pasivo,c_tipo_compania,
                 en_fecha_crea,en_fecha_mod,en_pais,en_filial,en_oficina,
                 en_tipo_dp,en_casilla,en_balance,c_es_grupo,p_propiedad,
                 en_comentario,en_retencion,en_mala_referencia,en_oficial,
                 en_asosciada,
                 en_referido,en_sector,
                 --	c_tipo_nit, c_tipo_soc,p_fecha_emision,--REC006
                 en_tipo_ced,c_tipo_soc,p_fecha_emision,--REC006
                 p_lugar_doc,c_total_activos,c_num_empleados,c_sigla,
                 en_rep_superban
                 ,
                 en_doc_validado,en_nomlar,en_situacion_cliente)
    /*** REC Reemplazo de valores por default 
    		values (@o_ente, 'C', @i_nombre,  
    			'0',null, @i_ruc,
    			null, null, null,
    			'0', @w_fecha,
    			@w_fecha, @w_pais, @i_filial, @i_oficina, 
    			'S', null,null,  -- en_tipo_dp en S porque tiene información incompleta MGV 04/07/2006
    			null, null, null,
    			'S', 'N', 0, 	
    			null, 0, '0',
    			@i_tipo_nit, '0', null,
    			0, null, 0,
    			null, 'N', 'N', null)  Remplazo */

    values      (@o_ente,'C',@i_nombre,@w_actividad,null,
                 @i_ruc,null,null,null,@w_tipo_compania,
                 @w_fecha,@w_fecha,@w_pais,@i_filial,@i_oficina,
                 'S',null,null,
                 --null, null, null, REC053
                 'N',null,
                 null,--REC053		
                 'S','N',@w_oficial,@i_regimen_fiscal,
                 @w_referido,@w_sectoreco,@i_tipo_nit,@w_tip_soc,null,
                 @w_ciudad,null,0,null,'N',
                 @i_doc_validado,@i_nombre,'NOR')

  /****Fin REC VALORES POR DEFECTO ***/
    /* si no se pudo insertar, error */
    if @@error != 0
    begin
      exec cobis..sp_cerror
        /* Error en insercion de compania */
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 105006
      return 1
    end
    /*insertar ejecutivo de cuenta */
    insert into cl_ejecutivo
                (ej_ente,ej_funcionario,ej_toficial,ej_fecha_asig)
    values      (@o_ente,@w_oficial,'C',getdate())
    if @@error != 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101116
    /*error en insercion de ejecutivo de ente*/
    end
    insert into cl_his_ejecutivo
                (ej_ente,ej_funcionario,ej_toficial,ej_fecha_asig,
                 ej_fecha_registro)
    values      (@o_ente,@w_oficial,'C',getdate(),getdate())
    if @@error != 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101116
    /*error en insercion de ejecutivo de ente*/
    end
  /*termina actualizar ejecutivo*/
    /* transaccion de servicio - nuevo creacion rapida */
    insert into ts_compania
                (secuencial,tipo_transaccion,clase,fecha,usuario,
                 terminal,srv,lsrv,compania,nombre,
                 ruc,actividad,posicion,grupo,activo,
                 pasivo,tipo,pais,filial,oficina,
                 casilla_def,tipo_dp,retencion,mala_referencia,comentario,
                 oficial,asosciada,referido,tipo_nit,sector,
                 tipo_soc,fecha_emision,lugar_doc,total_activos,num_empleados,
                 sigla,rep_superban,doc_validado,tipo_vinculacion,vinculacion,
                 exc_sipla,nivel_ing,nivel_egr,exc_por2,categoria)
    /* JAL FEB/01*/
    values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                 @s_term,@s_srv,@s_lsrv,@o_ente,@i_nombre,
                 @i_ruc,@w_actividad,null,null,null,
                 null,'0',@w_pais,@i_filial,@i_oficina,
                 null,'S',null,
                 -- en_tipo_dp en S porque tiene información incompleta MGV 04/07/2006
                 'N','CREACION RAPIDA COMPANIA',
                 @w_oficial,@i_regimen_fiscal,null,@i_tipo_nit,@w_sectoreco,
                 @w_tip_soc,null,@w_ciudad,null,0,
                 null,'N','N',null,null,
                 null,null,null,null,null)

    if @@error != 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103005
      /* 'Error en creacion de transaccion de servicio'*/
      return 1
    end

    if @i_doc_validado = 'S'
    begin
      insert into cl_entes_validados
                  (ev_ente,ev_fecha,ev_usuario,ev_central,ev_origen)
      values      (@o_ente,@w_fecha,@s_user,@i_cod_central,
                   'CREACION RAPIDA COMPANIA')

      if @@error != 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103095
        return 1
      end
    end --@i_doc_validado='S'

  /* Devuelve los parametros al front-End */
  /*		select 	en_ente,
  			en_nombre,
  			en_ced_ruc,
  			en_tipo_ced
  		  from 	cl_ente
  		 where	en_ente = @o_ente */ /*  --NVR02	*/
    /*		 where	en_ente = @w_ente         NVR02 */

    commit tran
    select
      @o_ente,
      en_nombre,
      en_ced_ruc,
      en_tipo_ced
    from   cl_ente
    where  en_ente = @o_ente

    return 0
  end

go

