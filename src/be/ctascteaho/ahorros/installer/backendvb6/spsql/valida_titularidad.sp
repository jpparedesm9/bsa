use cob_ahorros
go

/************************************************************************/
/* ARCHIVO:         valida_titularidad.sp.sp                            */
/* NOMBRE LOGICO:   sp_valida_titularidad                               */
/* PRODUCTO:        CUENTAS DE AHORROS                                  */
/************************************************************************/
/*                         IMPORTANTE                                   */
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
/*                          PROPOSITO                                   */
/* Este stored procedure permite validar que un cliente solo            */
/* tenga una cuenta super cash y una cuenta super plus                  */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/* FECHA         AUTOR            RAZON                                 */
/* 24/mar/05     D.Villagomez     Emision Inicial                       */
/* 30/Mar/06     J. Suarez        Validacion producto 20                */
/* 12/Oct/06     P.Coello         VALIDAR CANTIDAD DE CUENTAS           */
/*                                POR CADA UNO DE LOS PRODUCTOS         */
/*                                POR PARAMETROS Y NO QUEMADO           */
/* 23/Nov/06     P.Coello         CAMBIAR ESQUEMA DE VALIDACION         */
/*                                DE CANTIDAD DE PRODUCTOS POR          */
/*                                CLIENTE, DADO QUE HAY CLIENTES        */
/*                                QUE ABREN CUENTAS A SU NOMBRE         */
/*                                PERO CORRESPONDEN A OTROS             */
/*                                CLIENTES (FIDEICOMISOS)               */
/* 02/May/2016   Walther Toledo   Migración a CEN                       */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_valida_titularidad')
  drop proc sp_valida_titularidad
go

create proc sp_valida_titularidad
(
  @s_ssn          int = null,
  @s_date         datetime = null,
  @s_user         varchar(30) = null,
  @s_ofi          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_trn          smallint = null,
  @i_prod_banc    smallint,
  @t_show_version bit = 0,
  @i_param1       varchar(255) = null,-- PARAMETRO TITULAR 1 ejemplo '4@gaby@'
  @i_param2       varchar(255) = null,-- PARAMETRO TITULAR 2
  @i_param3       varchar(255) = null,-- PARAMETRO TITULAR 3
  @i_param4       varchar(255) = null,-- PARAMETRO TITULAR 4
  @i_param5       varchar(255) = null,-- PARAMETRO TITULAR 5
  @i_param6       varchar(255) = null,-- PARAMETRO TITULAR 6
  @i_param7       varchar(255) = null,-- PARAMETRO TITULAR 7
  @i_param8       varchar(255) = null,-- PARAMETRO TITULAR 8
  @i_param9       varchar(255) = null,-- PARAMETRO TITULAR 9
  @i_param10      varchar(255) = null,-- PARAMETRO TITULAR 10
  @i_param11      varchar(255) = null,-- PARAMETRO TITULAR 11
  @i_param12      varchar(255) = null,-- PARAMETRO TITULAR 12
  @i_param13      varchar(255) = null,-- PARAMETRO TITULAR 13
  @i_param14      varchar(255) = null,-- PARAMETRO TITULAR 14
  @i_param15      varchar(255) = null,-- PARAMETRO TITULAR 15
  @i_param16      varchar(255) = null,-- PARAMETRO TITULAR 16
  @i_param17      varchar(255) = null,-- PARAMETRO TITULAR 17
  @i_param18      varchar(255) = null,-- PARAMETRO TITULAR 18
  @i_param19      varchar(255) = null,-- PARAMETRO TITULAR 19
  @i_param20      varchar(255) = null -- PARAMETRO TITULAR 20

)
as
  -- DECLARACION DE VARIABLES DE USO INTERNO
  declare
    @w_return     int,-- VALOR RETORNO SPS
    @w_sp_name    varchar(32),-- NOMBRE DEL STORED PROCEDURE
    @w_cont       tinyint,-- CONTADOR NUMERO DE REGISTROS
    @w_cadena     varchar(255),-- REGISTRO DE PROCESO
    @w_parametro  tinyint,-- CONTADOR NUMERO DE CAMPOS
    @w_posicion   smallint,-- POSICION DEL SEPARADOR
    @w_token      varchar(255),-- CAMPO DE PROCESO
    @w_codcliente int,-- CODIGO DE CLIENTE A EVALUAR
    @w_nombre     varchar(255),-- NOMBRE DE CLIENTE A EVALUAR
    @w_superplus  smallint,-- PARAMETRO DE PROD BAN SUPER PLUS
    @w_supercash  smallint,-- PARAMETRO DE PROD BAN SUPER PLUS
    @w_numcuentas int,-- NUMERO DE CUENTAS QUE ES TITULAR O COTITULAR
    @w_msg        varchar(132),-- MENSAJE PARA ERROR
    @w_ahorramas  int,--PCOELLO PRODUCTO AHORRA MAS
    @w_cant_suplu int,--PCOELLO CANTIDAD DE CUENTAS SUPERPLUS
    @w_cant_supca int,--PCOELLO CANTIDAD DE CUENTAS SUPERCASH
    @w_cant_ahmas int --PCOELLO CANTIDAD DE CUENTAS AHORRAMAS

  -- ASIGNAR EL NOMBRE DEL STORED PROCEDURE
  select
    @w_sp_name = 'sp_valida_titularidad'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  if @t_trn <> 344
  begin
    -- TIPO DE TRANSACCION NO CORRESPONDE
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 2902500
    return 1
  end

  -- LEE PARAMETROS
  select
    @w_superplus = null,
    @w_supercash = null

  select
    @w_superplus = pa_int
  from   cobis..cl_parametro
  where  pa_nemonico = 'PBSP'
     and pa_producto = 'AHO'

  select
    @w_supercash = pa_int
  from   cobis..cl_parametro
  where  pa_nemonico = 'PBSC'
     and pa_producto = 'AHO'

  /****PCOELLO LEER PARAMETRO PARA AHORRA MAS Y PARA CANTIDAD DE CUENTAS POR CADA PRODUCTO *****/
  select
    @w_ahorramas = pa_int
  from   cobis..cl_parametro
  where  pa_nemonico = 'PBAHMA'
     and pa_producto = 'AHO'

  select
    @w_cant_suplu = pa_int
  from   cobis..cl_parametro
  where  pa_nemonico = 'CASUPL'
     and pa_producto = 'AHO'

  select
    @w_cant_supca = pa_int
  from   cobis..cl_parametro
  where  pa_nemonico = 'CASUCA'
     and pa_producto = 'AHO'

  select
    @w_cant_ahmas = pa_int
  from   cobis..cl_parametro
  where  pa_nemonico = 'CAAHMA'
     and pa_producto = 'AHO'

  /****PCOELLO LEER PARAMETRO PARA AHORRA MAS Y PARA CANTIDAD DE CUENTAS POR CADA PRODUCTO *****/

  if @w_superplus is null
      or @w_supercash is null
      or @w_ahorramas is null
      or @w_cant_suplu is null
      or @w_cant_supca is null
      or @w_cant_ahmas is null
  begin
    -- 'NO SE PUEDEN LEER LOS PARAMETROS GENERALES'
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 2902501
    return 1
  end

  --print '@w_superplus %1!  @i_prod_banc  %2! @w_supercash %3!',@w_superplus,  @i_prod_banc,  @w_supercash

  if (@w_superplus = @i_prod_banc
       or @w_supercash = @i_prod_banc
       or @i_prod_banc = @w_ahorramas)
  begin
    -- INICIALIZAR CONTADOR
    select
      @w_cont = 1

    -- LAZO PARA PROCESO DE REGISTROS
    while @w_cont <= 20
    begin
      -- PROCESAR CADA UNO DE LOS PARAMETROS
      if @w_cont = 1
        select
          @w_cadena = @i_param1
      else if @w_cont = 2
        select
          @w_cadena = @i_param2
      else if @w_cont = 3
        select
          @w_cadena = @i_param3
      else if @w_cont = 4
        select
          @w_cadena = @i_param4
      else if @w_cont = 5
        select
          @w_cadena = @i_param5
      else if @w_cont = 6
        select
          @w_cadena = @i_param6
      else if @w_cont = 7
        select
          @w_cadena = @i_param7
      else if @w_cont = 8
        select
          @w_cadena = @i_param8
      else if @w_cont = 9
        select
          @w_cadena = @i_param9
      else if @w_cont = 10
        select
          @w_cadena = @i_param10
      else if @w_cont = 11
        select
          @w_cadena = @i_param11
      else if @w_cont = 12
        select
          @w_cadena = @i_param12
      else if @w_cont = 13
        select
          @w_cadena = @i_param13
      else if @w_cont = 14
        select
          @w_cadena = @i_param14
      else if @w_cont = 15
        select
          @w_cadena = @i_param15
      else if @w_cont = 16
        select
          @w_cadena = @i_param16
      else if @w_cont = 17
        select
          @w_cadena = @i_param17
      else if @w_cont = 18
        select
          @w_cadena = @i_param18
      else if @w_cont = 19
        select
          @w_cadena = @i_param19
      else if @w_cont = 20
        select
          @w_cadena = @i_param20

      -- SI LA CADENA ES NO NULA PROCESAR
      if @w_cadena is not null
      begin
        select
          @w_parametro = 0
        while @w_parametro < 2
        begin
          select
            @w_parametro = @w_parametro + 1
          select
            @w_posicion = charindex('@',
                                    @w_cadena)
          select
            @w_token = substring(@w_cadena,
                                 1,
                                 @w_posicion - 1)
          -- OBTENER CAMPOS DE CADA PARAMETRO
          if @w_parametro = 1
            select
              @w_codcliente = convert (int, @w_token)
          if @w_parametro = 2
            select
              @w_nombre = @w_token
          select
            @w_cadena = substring(@w_cadena,
                                  @w_posicion + 1,
                                  datalength(@w_cadena))
        end -- FIN DEL WHILE -NUMERO DE CAMPOS A PROCESAR

        -- VALIDACION DE QUE EL CLIENTE SOLO TENGA UNA SUPER PLUS O SUPER CASH
        select
          @w_numcuentas = 0

        --print  '@w_codcliente %1!',@w_codcliente

        select
          @w_numcuentas = count (*)
        from   cobis..cl_cliente,
               cobis..cl_det_producto
        where  cl_det_producto = dp_det_producto
           and cl_rol in ('T', 'C')
           and cl_cliente      = @w_codcliente
           and dp_producto     = 4
           and dp_estado_ser   = 'V'
           and dp_cuenta in
               (select
                  ah_cta_banco
                from   cob_ahorros..ah_cuenta
                where  ah_estado in ('A', 'I')
                   and ah_prod_banc = @i_prod_banc)
        -- parametro del producto bancario a evaluar

      /***** VALIDAR CANTIDAD DE CUENTAS POR CADA UNO DE LOS PRODUCTOS ****/
      /*   PCOELLO CAMBIAR ESQUEMA DE VALIDACION
      
      if ((@w_superplus = @i_prod_banc and @w_numcuentas >= @w_cant_suplu) or
          (@w_supercash = @i_prod_banc and @w_numcuentas >= @w_cant_supca) or
          (@w_ahorramas = @i_prod_banc and @w_numcuentas >= @w_cant_ahmas))
      begin
         select @w_msg = @w_nombre + ' YA POSEE AL MENOS UN CUENTA DEL PRODUCTO BANCARIO'
         -- EL CLIENTE YA POSEE AL MENOS UN CUENTA DEL PRODUCTO BANCARIO DEFINIDO'
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 251086,
            @i_msg   = @w_msg
         return 1
      end
      */
        /* PRIMERO SE VALIDA QUE NO HAYA UNA ASIGNACION DE CANTIDAD PARA EL CLIENTE ESPECIFICO EN EL PRODUCTO SOLICITADO*/
        select
          @w_cant_ahmas = pc_cantidad
        from   cob_remesas..re_producto_cliente
        where  pc_tipo_relacion = 'E'
           and pc_cliente       = @w_codcliente
           and pc_producto      = @i_prod_banc

        if @@rowcount = 0
        --SI NO EXISTE UNA CANTIDAD ESPECIFICA PARA EL CLIENTE ENTONCES SE
        begin
          --VALIDA SI EXISTE ALGUNA RESTRICCION PARA TODOS LOS CLIENTES EN EL PRODUCTO SOLICITADO
          select
            @w_cant_ahmas = pc_cantidad
          from   cob_remesas..re_producto_cliente
          where  pc_tipo_relacion = 'T'
             and pc_producto      = @i_prod_banc

          if @@rowcount = 0
            --SI NO EXISTE RESTRICCION PARA TODOS LOS CLIENTES ENTONCES LE ASIGNA UN NUMERO GRANDE
            select
              @w_cant_ahmas = 99999999
        end

        if @w_numcuentas >= @w_cant_ahmas
        begin
          select
            @w_msg =
            @w_nombre +
            ' YA POSEE MAS CUENTAS DE LAS PERMITIDAS PARA EL PRODUCTO BANCARIO'
          -- EL CLIENTE YA POSEE AL MENOS UN CUENTA DEL PRODUCTO BANCARIO DEFINIDO'
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 251086,
            @i_msg   = @w_msg
          return 1
        end

      end -- FIN DEL IF -CADENA NO NULA
      -- ACTUALIZAR CONTADOR
      select
        @w_cont = @w_cont + 1
    end -- FIN DEL WHILE -NUMERO DE PARAMETOS A PROCESAR

  end -- producto bancario

  return 0

go

