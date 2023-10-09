/************************************************************************/
/*      Archivo:                funcionario.sp                          */
/*      Stored procedure:       sp_funcionario                          */
/*      Base de datos:          cobis                                   */
/*      Producto:               Admin                                   */
/*      Disenado por:           Mauricio Bayas/Sandra Ortiz             */
/*      Fecha de escritura:     15-Nov-1992                             */
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
/*      Este programa procesa las transacciones del stored procedure    */
/*      Insercion de funcionario                                        */
/*      Actualizacion de funcionario                                    */
/*      Borrado de funcionario                                          */
/*                                                                      */
/*      Adicionalmente llama al stored procedure sp_cons_funcionario    */
/*      para las operaciones:                                           */
/*      Busqueda de funcionario                                         */
/*      Query de funcionario                                            */
/*      Help de funcionario                                             */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      15/Nov/92       S. Ortiz        Emision Inicial                 */
/*      14/Ene/93       L. Carvajal     Tabla de errores, variables     */
/*                                      de debug                        */
/*      10/Nov/93       P/ Mena         Help del funcionario cuyo rol   */
/*                                      sea oficial de cuenta y de      */
/*                                      credito.                        */
/*      09/Mar/94       F. Espinosa     Anular el envio del parametro   */ 
/*                                      i_dinero                        */
/*      11/Abr/94       F. Espinosa     Incluir campo nomina en las ope_*/
/*                                      operaciones con la tabla        */
/*                                      cl_funcionario                  */
/*      12/Abr/94       F. Espinosa     Division del stored procedure   */
/*                                      en dos partes por exeso en el   */
/*                                      tamanio del query               */
/*      25/Abr/94       F. Espinosa     Parametros tipo "S"             */
/*                                      Transacciones de Servicio       */
/*      08/Sep/94       C. Rodriguez    Considerar la oficina           */
/*      16/Nov/00       A. Rodrfguez    Control de tamaño del Passwd    */
/*                                      Control de repet. del Passwd    */
/*      18/Ene/01       A. Rodrfguez    Nuevo esquema encriptacion      */
/*      24/Abr/01       A. Duque        Cambio de password NCS          */
/*      06/Jun/12       D. Vera         Cambio tipo dato parametro      */
/*                                      i_nomina                        */
/*      25/Jul/12       J. Nieto        Modificaci¢n a un alias         */
/*  07/09/2012          Miguel Aldaz Si @i_jefe = null le ponemos @i_jefe = 0*/
/*  11/09/2012          Mario Velez     Se aplica Validaciones para M&C */
/*  11-04-2016          BBO             Migracion Sybase-Sqlserver FAL  */
/************************************************************************/
use cobis
go

if exists (select 1 from sysobjects where name = 'sp_funcionario')
   drop proc sp_funcionario
go

create proc sp_funcionario (
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
   @t_offset               varbinary(32) = NULL,    -- ARO:18/01/2001   CRYPWD
   @t_tampwd               int           = NULL,              -- ARO:18/01/2001   CRYPWD
   @t_show_version         bit             = 0, -- Mostrar la version del programa  --(PRMR STANDAR)
   @mc_validacion          int = 0,                -- Mario Velez, 11/Sep/2012, Para Validaciones de M&C
   @i_chpass               char(1)       = 'S',          -- ADU:24/04/2001   NCS
   @i_operacion            char(1),
   @i_modo                 tinyint       = NULL,
   @i_tipo                 char(1)       = NULL,
   @i_funcionario          smallint      = NULL,
   @i_nombre               descripcion   = NULL,
   @i_login                varchar(30)   = NULL,
   @i_clave                varchar(30)   = NULL,
   @i_sexo                 sexo          = NULL,
   @i_nomina               int           = NULL, --DVE cambio de smallint a int
   @i_dinero               char(1)       = 'N',
   @i_departamento         smallint      = NULL,
   @i_oficina              smallint      = NULL,
   @i_cargo                smallint      = NULL,
   @i_secuencial           tinyint       = NULL,
   @i_jefe                 int           = 0,
   @i_estado               varchar(1)    = "V",
   @i_central_transmit     varchar(1)    = null,
   @i_cedula               varchar(30)   = null,
   @i_causa_bloqueo        catalogo      = null,
   @o_siguiente            int           = NULL out
)
as
declare
   @w_today           datetime,
   @w_return          int,
   @w_cambio          char(1),
   @w_sp_name         varchar(32),
   @w_codigo          int,
   @w_funcionario     smallint,
   @w_nombre          descripcion,
   @w_login           varchar(30),
   @w_clave           varchar(30),
   @w_offset          varbinary(32),     -- ARO:18/01/2001       CRYPWD
   @w_sexo            sexo,
   @w_dinero          char(1),
   @w_nomina          int, --DVE cambio de smallint a int
   @w_departamento    smallint,
   @w_oficina         smallint,
   @w_cargo           smallint,
   @ww_departamento   smallint,
   @ww_oficina        smallint,
   @ww_cargo          smallint,
   @w_jefe            int,
   @w_numero          tinyint,
   @w_secuencial      tinyint,
   @ww_secuencial     tinyint,
   @w_valor           descripcion,
   @w_nivel           tinyint,
   @w_estado          char(1),
   @v_estado          char(1),
   @v_funcionario     smallint,
   @v_nombre          descripcion,
   @v_sexo            sexo,
   @v_dinero          char(1),
   @v_nomina          int, --DVE cambio de smallint a int
   @v_departamento    smallint,
   @v_oficina         smallint,
   @v_cargo           tinyint,
   @v_clave           varchar(30),
   @v_offset          varbinary(32),     -- ARO:18/01/2001       CRYPWD
   @v_secuencial      tinyint,
   @v_jefe            smallint,
   @v_nivel           tinyint,
   @v_login           varchar(30),
   @o_funcionario     smallint,
   @o_nombre          descripcion,
   @o_login           varchar(30),
   @o_sexo            sexo,
   @o_senombre        descripcion,
   @o_dinero          char(1),
   @o_nomina          int, -- DVE cambio de smallint a int
   @o_departamento    smallint,
   @o_oficina         smallint,
   @o_denombre        descripcion,
   @o_cargo           smallint,
   @o_canombre        descripcion,
   @o_secuencial      tinyint,
   @o_jefe            int,
   @o_jenombre        descripcion,
   @o_nivel           tinyint,
   @w_cmdtransrv      varchar(60),
   @w_nt_nombre       varchar(40),
   @w_num_nodos       smallint,
   @w_contador        smallint,
   @w_clave_int       int,
   @w_tmp             tinyint,
   @w_tp              tinyint,
   @w_npch            tinyint,
   @w_clave_his       varchar(30),
   @w_offset_his      varbinary(32), -- ARO:18/01/2001 CRYPWD
   @w_contador_his    int,
   @w_sec_his         int,
   @w_tml             tinyint,
   @w_tl              tinyint,
   @w_dbp             smallint,
   @w_fec_ult_in      datetime,
   @w_dvpw            smallint,
   @w_cedula          varchar(30),
   @w_causa_bloqueo   catalogo,
   @v_cedula          varchar(30),
   @v_causa_bloqueo   catalogo,
   @w_fecha_cargo     datetime,
   @w_fecha_cargo_ant datetime

select @w_today = @s_date
select @w_sp_name = 'sp_funcionario'

/*****************************************************************************/
------MC Mario Velez, 11/Sep/2012, INICIO: Validaciones de negocio Para M&C
/*****************************************************************************/
IF @mc_validacion = 1
   BEGIN
      IF @i_operacion = 'I'
         BEGIN 
            IF @t_trn = 598
               BEGIN
                  --CHEQUEO DE CLAVES FORANEAS
                  if @i_jefe IS  NULL /* Si @i_jefe = null le ponemos @i_jefe = 0 maldaz 07/09/2012*/
                     begin        
                        select @i_jefe = 0
                     end                
                  --MALDAZ 07/09/2012
                
                  IF @i_jefe = 0
                     SELECT @w_nivel = 0
                  ELSE 
                     BEGIN   
                        SELECT @w_nivel = isnull(fu_nivel,0)
                        FROM cl_funcionario
                        WHERE fu_funcionario = @i_jefe

                        IF @@rowcount = 0
                           BEGIN 
                              EXEC sp_cerror
                                 @t_debug        = @t_debug,
                                 @t_file         = @t_file,
                                 @t_from         = @w_sp_name,
                                 @i_num          = 101011
                                 --JEFE NO EXISTE
                              RETURN 1
                           END
            
                        SELECT @w_nivel = @w_nivel + 1
                     END 

                  IF NOT EXISTS(SELECT de_departamento
                              FROM cl_departamento
                              WHERE de_departamento = @i_departamento
                              AND de_oficina = @i_oficina )
                     BEGIN 
                        EXEC sp_cerror
                           @t_debug        = @t_debug,
                           @t_file         = @t_file,
                           @t_from         = @w_sp_name,
                           @i_num          = 101010
                           --DEPARTAMENTO NO EXISTE
                        RETURN 1
                     END 
          
                  SELECT @w_valor = convert(VARCHAR(10), @i_cargo)
          
                  EXEC @w_return = sp_catalogo
                     @t_debug        = @t_debug,
                     @t_file         = @t_file,
                     @t_from         = @w_sp_name,
                     @i_tabla        = 'cl_cargo',
                     @i_operacion    = 'E',
                     @i_codigo       =  @w_valor

                  IF @w_return != 0
                     BEGIN 
                        EXEC sp_cerror
                           @t_debug        = @t_debug,
                           @t_file         = @t_file,
                           @t_from         = @w_sp_name,
                           @i_num          = 101012
                           --NO EXISTE CARGO
                        return 1
                     END 

                  IF EXISTS(SELECT fu_login
                           FROM cl_funcionario
                           WHERE fu_login = @i_login)
                     BEGIN 
                        EXEC sp_cerror
                           @t_debug        = @t_debug,
                           @t_file         = @t_file,
                           @t_from         = @w_sp_name,
                           @i_num          = 101062
                           --LOGIN YA EXISTE
                        RETURN 1
                     END 

                  SELECT @w_secuencial = ds_secuencial
                  FROM cl_distributivo
                  WHERE ds_departamento = @i_departamento
                  AND ds_oficina = @i_oficina
                  AND ds_cargo = @i_cargo
                  AND ds_secuencial = @i_secuencial 
                  AND ds_vacante = 'S' 

                  IF @@rowcount = 0
                     BEGIN 
                        EXEC sp_cerror
                           @t_debug        = @t_debug,
                           @t_file         = @t_file,
                           @t_from         = @w_sp_name,
                           @i_num          = 101051
                           --NO EXISTE VACANTE
                        RETURN 1
                     END 

                  --CHEQUEO DE LONGITUD MINIMA DE LOGIN
                  --ARO: 16 DE NOVIEMBRE
                  SELECT @w_tml=isnull(pa_tinyint,0)
                  FROM cl_parametro
                  WHERE pa_producto='ADM' 
                  AND pa_nemonico='TML' 

                  IF @@rowcount=0
                     BEGIN 
                        EXEC sp_cerror
                           @t_debug        = @t_debug,
                           @t_file         = @t_file,
                           @t_from         = @w_sp_name,
                           @i_num          = 151126
                           --NO EXISTE PARÁMETRO GENERAL
                        RETURN 1 
                     END 
             
                  SELECT @w_tl= isnull(datalength (@i_login),0)

                  IF @w_tl < @w_tml
                     BEGIN 
                        EXEC sp_cerror
                           @t_debug        = @t_debug,
                           @t_file         = @t_file,
                           @t_from         = @w_sp_name,
                           @i_num          = 151127
                        PRINT 'Longitud minima del Login es '+  convert(varchar, @w_tml) + ' caracteres' --mig syb-sql 11032016
                        --TAMANIO DE LOGIN INCORRECTO
                        RETURN 1
                     END 
                  --FIN ARO

                  --CHEQUEO DE LONGITUD MINIMA DE PASSWORD
                  --ARO: 15 DE NOVIEMBRE
                  SELECT @w_tmp=isnull(pa_tinyint,0)
                  FROM cl_parametro
                  WHERE pa_producto='ADM' 
                  AND pa_nemonico='TMP'

                  IF @@rowcount=0
                     BEGIN 
                        EXEC sp_cerror
                           @t_debug        = @t_debug,
                           @t_file         = @t_file,
                           @t_from         = @w_sp_name,
                           @i_num          = 151122
                           --NO EXISTE PARÁMETRO GENERAL
                        RETURN 1 
                     END 
            
                  --ARO:18/01/2001 CRYPWD
                  --select @w_tp=isnull(datalength(@i_clave),0)
                  SELECT @w_tp=isnull(@t_tampwd,0)
                  --FIN ARO CRYPWD

                  IF @w_tp<@w_tmp 
                     BEGIN 
                        EXEC sp_cerror
                           @t_debug        = @t_debug,
                           @t_file         = @t_file,
                           @t_from         = @w_sp_name,
                           @i_num          = 151123
                           PRINT 'Longitud minima del Password es ' + convert(varchar, @w_tmp) + ' caracteres'
                           --LONGITUD DE PASSWORD INCORRECTA
                        RETURN 1 
                     END 
                     --FIN ARO

                  /***  Validar longitd maxima de campo nomina ***/
                  /*** DVE 06/06/2012 ***/
                  IF @i_nomina > 2147483647
                     BEGIN
                        EXEC sp_cerror
                           @t_debug  = @t_debug,
                           @t_file   = @t_file,
                           @t_from   = @w_sp_name,
                           @i_num    = 189003
                        RETURN 1 
                     END 
               END -- IF @t_trn = 598
         END -- IF @i_operacion = 'I'
   ------------------------------------------

      IF @i_operacion = 'D'
         BEGIN 
            IF @t_trn = 1510
               BEGIN
                  --CHEQUEO DE REFERENCIAS
                  IF NOT EXISTS(SELECT fu_funcionario
                              FROM cl_funcionario
                              WHERE fu_funcionario = @i_funcionario)
                     BEGIN 
                        EXEC sp_cerror
                           @t_debug        = @t_debug,
                           @t_file         = @t_file,
                           @t_from         = @w_sp_name,
                           @i_num          = 101036
                           --FUNCIONARIO NO EXISTE
                        RETURN 1
                     END 

                  IF EXISTS(SELECT fu_funcionario
                           FROM cl_funcionario
                           WHERE fu_jefe = @i_funcionario)
                     BEGIN 
                        EXEC sp_cerror
                           @t_debug        = @t_debug,
                           @t_file         = @t_file,
                           @t_from         = @w_sp_name,
                           @i_num          = 151058
                           --EXISTEN FUNCIONARIOS SUBALTERNOS A ESTE
                        RETURN 1
                     END 

                  SELECT @w_login = fu_login 
                  FROM cl_funcionario
                  WHERE fu_funcionario = @i_funcionario

                  --REFERENCIA EN AD_USUARIO
                  IF EXISTS (SELECT us_login
                           FROM ad_usuario
                           WHERE us_login = @w_login)
                     BEGIN 
                        EXEC sp_cerror
                           @t_debug        = @t_debug,
                           @t_file         = @t_file,
                           @t_from         = @w_sp_name,
                           @i_num          = 101064
                           --EXISTE REFERENCIA EN AD_USUARIO
                        RETURN 1
                     END 

                  --REFERENCIA EN AD_USUARIO_ROL
                  IF EXISTS(SELECT ur_login
                           FROM ad_usuario_rol
                           WHERE ur_login = @w_login)
                     BEGIN 
                        EXEC sp_cerror
                           @t_debug        = @t_debug,
                           @t_file         = @t_file,
                           @t_from         = @w_sp_name,
                           @i_num          = 101063
                           --EXISTE REFERENCIA EN AD_USUARIO_ROL
                        RETURN 1
                     END 

                  --REFERENCIA EN CC_OFICIAL
                  IF EXISTS(SELECT oc_funcionario
                           FROM cc_oficial
                           WHERE oc_funcionario = @i_funcionario)
                     BEGIN 
                        EXEC  sp_cerror
                           @t_debug        = @t_debug,
                           @t_file         = @t_file,
                           @t_from         = @w_sp_name,
                           @i_num          = 151090
                           --OFICIAL TIENE SUBORDINADOS, NO PUEDE ELIMINARSE
                        RETURN 1
                     END 

                  --REFERENCIA EN CC_OFICIAL
                  IF EXISTS(SELECT oc_funcionario
                           FROM cc_oficial
                           WHERE oc_funcionario = @i_funcionario)
                     BEGIN 
                        EXEC sp_cerror
                           @t_debug        = @t_debug,
                           @t_file         = @t_file,
                           @t_from         = @w_sp_name,
                           @i_num          = 151090
                           --OFICIAL TIENE SUBORDINADOS, NO PUEDE ELIMINARSE
                        RETURN 1
                     END 
            END -- IF @t_trn = 1510
         END -- IF @i_operacion = 'D'

      RETURN 0
   END -- IF @mc_validacion = 1
/*****************************************************************************/
------MC MARIO VELEZ, 11/SEP/2012, FIN VALIDACIONES DE NEGOCIO PARA M&C
/*****************************************************************************/

/* Creacion de tabla temporal de nodos a distribuir */
/* Si esta en ambiente UNIX SYBASE                  */

if (@i_operacion = 'I' or @i_operacion = 'U' or @i_operacion = 'D') and (@i_central_transmit is NULL)
begin
   --create table #ad_nodo_reentry_tmp (nt_nombre  varchar(60), nt_bandera char (1))     Mario Velez; 24/Oct/2012; 
   delete from ad_nodo_reentry_tmp
end


/***Mostrar versionamiento del sp ***/--(PRMR STANDAR)
        if @t_show_version = 1
        begin
                print 'Stored procedure sp_funcionario, Version 4.0.0.1'
                return 0
        end


/* ** Insert ** */
IF @i_operacion = 'I'
BEGIN 
  IF @t_trn = 598
  BEGIN
    /* chequeo de claves foraneas */
        if @i_jefe IS  NULL /* Si @i_jefe = null le ponemos @i_jefe = 0 maldaz 07/09/2012*/
    begin        
          select @i_jefe = 0
        end                
        /* maldaz 07/09/2012*/
        
    IF @i_jefe = 0
      SELECT @w_nivel = 0
    ELSE 
    BEGIN   
      SELECT @w_nivel = isnull(fu_nivel,0)
      FROM cl_funcionario
      WHERE fu_funcionario = @i_jefe
      IF @@rowcount = 0
      BEGIN 
        EXEC sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 101011
              /*'Jefe no existe'*/
        RETURN 1
      END
    
      SELECT @w_nivel = @w_nivel + 1
    END 

    IF NOT EXISTS ( 
      SELECT de_departamento
      FROM cl_departamento
      WHERE de_departamento = @i_departamento
      AND de_oficina = @i_oficina )
    BEGIN 
      EXEC sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 101010
            /*'Departamento no existe'*/
      RETURN 1
    END 
  
    SELECT @w_valor = convert(VARCHAR(10), @i_cargo)
  
    EXEC @w_return = sp_catalogo
          @t_debug        = @t_debug,
          @t_file         = @t_file,
          @t_from         = @w_sp_name,
          @i_tabla        = 'cl_cargo',
          @i_operacion    = 'E',
          @i_codigo       =  @w_valor
    IF @w_return != 0
    BEGIN 
      EXEC sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 101012
            /*'No existe cargo'*/
      return 1
    END 

    IF EXISTS(
           SELECT fu_login
             FROM cl_funcionario
            WHERE fu_login = @i_login)
    BEGIN 
      EXEC sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 101062
            /*Login ya existe */
      RETURN 1
    END 

    SELECT @w_secuencial = ds_secuencial
    FROM cl_distributivo
    WHERE ds_departamento = @i_departamento
    AND ds_oficina = @i_oficina
    AND ds_cargo = @i_cargo
    AND ds_secuencial = @i_secuencial 
    AND ds_vacante = 'S' 
    IF @@rowcount = 0
    BEGIN 
      EXEC sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 101051
            /*'No existe vacante'*/
      RETURN 1
    END 

    /*** Chequeo de longitud minima de Login ***/
    /*** ARO: 16 de Noviembre ***/
    SELECT @w_tml=isnull(pa_tinyint,0)
    FROM cl_parametro
    WHERE pa_producto='ADM' 
    AND pa_nemonico='TML' 
    IF @@rowcount=0
    BEGIN 
      EXEC sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 151126
            /*No existe Parámetro General*/
      RETURN 1 
    END 
     
    SELECT @w_tl= isnull(datalength (@i_login),0)

    IF @w_tl < @w_tml
    BEGIN 
      EXEC sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 151127

        PRINT 'Longitud minima del Login es ' + convert(varchar, @w_tml) + ' caracteres' 

            /*Tamanio de Login Incorrecto */  
      RETURN 1
    END 
    /**** FIN ARO ****/

    /*** Chequeo de longitud minima de Password ***/
    /*** ARO: 15 de Noviembre ***/
    SELECT @w_tmp=isnull(pa_tinyint,0)
    FROM cl_parametro
    WHERE pa_producto='ADM' 
    AND pa_nemonico='TMP'
 
    IF @@rowcount=0
    BEGIN 
      EXEC sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 151122
            /*No existe Parámetro General  */
      RETURN 1 
    END 
    
    /*** ARO:18/01/2001 CRYPWD ***/ 
    --select @w_tp=isnull(datalength(@i_clave),0)
    SELECT @w_tp=isnull(@t_tampwd,0)
    /*** FIN ARO CRYPWD ****/

    IF @w_tp<@w_tmp 
    BEGIN 
      EXEC sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 151123

        PRINT 'Longitud minima del Password es ' + convert(varchar, @w_tmp) + ' caracteres'

            /*Longitud de Password incorrecta */
        RETURN 1 
    END 
    /**** FIN ARO ****/

    /***  Validar longitd maxima de campo nomina ***/
    /*** DVE 06/06/2012 ***/
    IF @i_nomina > 2147483647
    BEGIN
      EXEC sp_cerror
        @t_debug  = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
            @i_num    = 189003

      RETURN 1 
    END 
    /*** FIN DVE ***/

    BEGIN TRAN 
     exec sp_cseqnos
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_tabla        = 'cl_funcionario',
                @o_siguiente    = @o_siguiente out

     INSERT INTO cl_funcionario(
       fu_funcionario,    fu_nombre,       fu_sexo,           fu_dinero,
       fu_departamento,   fu_oficina,      fu_cargo,          fu_secuencial, 
       fu_jefe,           fu_nivel,        fu_fecha_ing,      fu_login,
       fu_nomina,         fu_clave,        fu_estado,         fu_offset,
       fu_fec_inicio,     fu_cedruc,       fu_causa_bloqueo,  fu_fecha_cargo)
     VALUES (
        @o_siguiente,      @i_nombre,    @i_sexo,           @i_dinero,
        @i_departamento,   @i_oficina,   @i_cargo,          @w_secuencial,
        @i_jefe,           @w_nivel,     @w_today,          @i_login,
        @i_nomina,         @i_clave,     'V',               @t_offset, 
        getdate(),         @i_cedula,    @i_causa_bloqueo,  @s_date)
     IF @@error != 0
     BEGIN 
       EXEC sp_cerror
                 @t_debug        = @t_debug,
                 @t_file         = @t_file,
                 @t_from         = @w_sp_name,
                 @i_num          = 103046
         /* 'Error en creacion de funcionario'*/
       RETURN 1
     END 
  
     UPDATE cl_distributivo
        SET ds_vacante = 'N'
      WHERE ds_departamento = @i_departamento
        AND ds_oficina = @i_oficina
        AND ds_cargo = @i_cargo
        AND ds_secuencial = @i_secuencial 
     /* transaccion de servicio - funcionario */

     INSERT INTO ts_funcionario (
        secuencia,      tipo_transaccion,   clase,         fecha,    oficina_s,
        usuario,        terminal_s,         srv,           lsrv,     login,
        funcionario,    nombre,             sexo,          dinero,   departamento,   
        oficina,        cargo,              secuencia_f,   jefe,     nivel,
        nomina,         clave,              estado,        offset,   cedula,
        causa_bloqueo)
     VALUES (
        @s_ssn,            598,         'N',             @s_date,     @s_ofi, 
        @s_user,           @s_term,     @s_srv,          @s_lsrv,     @i_login, 
        @o_siguiente,      @i_nombre,   @i_sexo,         @i_dinero,   @i_departamento,
        @i_oficina,        @i_cargo,    @w_secuencial,   @i_jefe,     @w_nivel,
        @i_nomina,         @i_clave,    @i_estado,       @t_offset,   @w_cedula,
        @w_causa_bloqueo)
     IF @@error != 0
     BEGIN 
       EXEC sp_cerror
                 @t_debug        = @t_debug,
                 @t_file         = @t_file,
                 @t_from         = @w_sp_name,
                 @i_num          = 103005
           /*'Error en creacion de transaccion de servicio'*/
       RETURN 1
     END 

    /**** ARO: 16 de Noviembre del 2000 ***/
    /*** Control Historico de Passwords (evitar repeticiones) ****/
    SELECT @w_sec_his=isnull(max(ch_secuencial),0)+1
    FROM cl_clave_his
    WHERE ch_login=@i_login
    
    INSERT INTO cl_clave_his (
      ch_login,
      ch_secuencial,
      ch_fecha,
      -- ch_clave)              ARO:18/01/2001  CRYPWD
          ch_offset)
    VALUES (
      @i_login,
      @w_sec_his,
      getdate(),
      -- @i_clave)              ARO:18/01/2001  CRYPWD
          @t_offset)
    IF @@error != 0
    BEGIN 
          EXEC sp_cerror
            @t_debug      = @t_debug,
            @t_file       = @t_file,
            @t_from       = @w_sp_name,
            @i_num        = 153051
            /*'Error en insercion en CL_CLAVE_HIS' */
          RETURN 1
    END 
    /***** FIN ARO ******/

    SELECT @o_siguiente
    COMMIT TRAN 

    /* Generacion del comando al transrv */
    --SELECT @w_cmdtransrv = @s_lsrv +'...sp_addlogin'
    SELECT @w_cmdtransrv = @s_lsrv +'...rp_tr_addlogin'     --migracion sqlserver 06052016
    
    /*EXEC @w_cmdtransrv
          @loginame = @i_login,
          @passwd   = @i_clave
    */  
    --Migracion sqlserver 
    EXEC @w_cmdtransrv
          @i_loginame = @i_login,
          @i_password   = @i_clave          
          
    /******************************* Para   Unix  **************************/
        --INSERT INTO #ad_nodo_reentry_tmp          Mario Vélez: 24/oct/2012
        INSERT INTO ad_nodo_reentry_tmp
        SELECT nl_nombre,'N'
          FROM ad_nodo_oficina,ad_server_logico
         WHERE nl_nombre <> @s_lsrv
           AND nl_filial   = sg_filial_i
           AND nl_oficina  = sg_oficina_i
           AND nl_nodo     = sg_nodo_i
           AND sg_producto = 1
           AND sg_tipo     = 'R'
           AND sg_moneda   = 0

        SELECT @w_num_nodos = count(*) from ad_nodo_reentry_tmp -- #ad_nodo_reentry_tmp   Mario Vélez: 24/oct/2012
        SELECT @w_contador = 1
        
        WHILE @w_contador <= @w_num_nodos
        BEGIN 
          SET ROWCOUNT 1
          SELECT @w_cmdtransrv = 'REENTRY' + '.' + nt_nombre + '.cobis.' +
        @w_sp_name,@w_nt_nombre = nt_nombre
          FROM ad_nodo_reentry_tmp -- #ad_nodo_reentry_tmp   ! Mario Vélez: 24/oct/2012
          WHERE nt_bandera = 'N'

          SET ROWCOUNT 0
          UPDATE ad_nodo_reentry_tmp  SET nt_bandera = 'S'
          WHERE nt_nombre  = @w_nt_nombre

          EXEC @w_return = @w_cmdtransrv
                @t_trn              = @t_trn,
                @i_operacion        = @i_operacion,
                @i_secuencial       = @i_secuencial,
                @i_funcionario      = @o_siguiente,
                @i_login            = @i_login,
                @i_nombre           = @i_nombre,
                @i_sexo             = @i_sexo,
                @i_dinero           = @i_dinero,
                @i_nomina           = @i_nomina,
                @i_departamento     = @i_departamento,
                @i_oficina          = @i_oficina,
                @i_cargo            = @i_cargo,
                @i_jefe             = @i_jefe,
                @i_estado           = @i_estado,
                @i_nivel            = @w_nivel,
                @i_central_transmit = 'S',
                @o_clave            = @w_clave_int out

           IF @w_return <> 0
             RETURN @w_return

           EXEC @w_return = cobis..sp_reentry
                 @i_key = @w_clave_int,
                 @i_tipo = 'I'

           IF @w_return <> 0
                 RETURN @w_return

           SELECT @w_contador = @w_contador + 1
           CONTINUE 
        END 
         
        DELETE ad_nodo_reentry_tmp  -- #ad_nodo_reentry_tmp       Mario Vélez: 24/oct/2012
        
    /******************************* Para   Unix  **************************/

    RETURN 0
  END 
  ELSE 
  BEGIN 
        EXEC sp_cerror
          @t_debug      = @t_debug,
          @t_file       = @t_file,
          @t_from       = @w_sp_name,
          @i_num        = 151051
          /*'No corresponde codigo de transaccion' */
        RETURN 1
  END 
END 


/*** Update ***/
IF @i_operacion = 'U'
BEGIN 
  IF @t_trn = 599
  BEGIN 
    /* verificacion de claves foraneas */
    IF @i_funcionario = @i_jefe
    BEGIN 
      EXEC sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 101058
            /*'Debe haber un jefe diferente'*/
      RETURN 1
    END 

    IF NOT EXISTS (
    SELECT fu_funcionario
    FROM cl_funcionario
    WHERE fu_funcionario = @i_funcionario)
    BEGIN 
      EXEC sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 101036
            /*'Funcionario no existe'*/
      RETURN 1
    END 
    
    IF @i_jefe = 0 OR @i_jefe IS NULL 
      SELECT @w_codigo = 0
    ELSE 
    BEGIN 
      SELECT @w_codigo = fu_nivel
      FROM cl_funcionario
      WHERE fu_funcionario = @i_jefe
      IF @@rowcount = 0
      BEGIN 
        EXEC sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 101011
              /* 'Jefe no existe'*/
        RETURN 1
      END 
      
      select @w_codigo = @w_codigo + 1
    END 

    IF NOT EXISTS ( 
      SELECT de_departamento
      FROM cl_departamento
      WHERE de_departamento = @i_departamento 
      AND de_oficina = @i_oficina)
    BEGIN 
      EXEC sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 101010
            /*'Departamento no existe'*/
      RETURN 1
    END 

    SELECT @w_valor = convert(VARCHAR(10), @i_cargo)
    EXEC @w_return = sp_catalogo
          @t_debug        = @t_debug,
          @t_file         = @t_file,
          @t_from         = @w_sp_name,
          @i_tabla        = 'cl_cargo',
          @i_operacion    = 'E',
          @i_codigo       =  @w_valor
    IF @w_return != 0
    BEGIN 
      EXEC sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 101012
            /* 'No existe cargo'*/
      RETURN 1
    END 

    /*** Verifica si es cambio de Password ***/
    /************ ADU: 24/04/2001 ************/
    IF @i_chpass='S'
    BEGIN 
      /************ ADU: 24/04/2001 ************/
      /*** Chequeo de longitud minima de Password ***/
      /*** ARO: 15 de Noviembre ***/
      SELECT @w_tmp=isnull(pa_tinyint,0)
      FROM cl_parametro
      WHERE pa_producto='ADM' 
      AND pa_nemonico='TMP'
 
      IF @@rowcount=0
      BEGIN 
        EXEC sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 151122
              /* No existe Parámetro General  */
        RETURN 1 
      END 
 
      /***  Validar longitd maxima de campo nomina ***/
      /*** DVE 06/06/2012 ***/
      IF @i_nomina > 2147483647
      BEGIN
        EXEC sp_cerror
          @t_debug  = @t_debug,
              @t_file   = @t_file,
              @t_from   = @w_sp_name,
              @i_num    = 189003

        RETURN 1 
      END 
      /*** FIN DVE ***/ 
 
      /*** ARO:18/01/2001  CRYPWD ***/
      --  select @w_tp=isnull(datalength(@i_clave),0)
      SELECT @w_tp=isnull(@t_tampwd,0)
      /*** FIN ARO CRYPWD ***/

      IF @w_tp<@w_tmp 
      BEGIN 
        EXEC sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 151123

        PRINT 'Longitud minima del Password es ' + convert(varchar, @w_tmp) + ' caracteres'

            /* Longitud de Password incorrecta */
        RETURN 1 
      END 

      /**** FIN ARO ****/
      /************ ADU: 24/04/2001 ************/
    END 
    /********** FIN ADU: 24/04/2001 **********/

    /* verificacion de campos actualizados */
    SELECT @w_nombre = fu_nombre,
          @w_sexo = fu_sexo,
          @w_dinero = fu_dinero,
          @w_nomina = fu_nomina,
          @w_departamento = fu_departamento,
          @w_oficina = fu_oficina,
          @w_cargo = fu_cargo,
          @w_secuencial = fu_secuencial,
          @w_jefe = fu_jefe,
          @w_nivel = fu_nivel,
          @w_clave = fu_clave,
          @w_offset = fu_offset,
          @w_estado = fu_estado,
          @w_login = fu_login,
          @w_cedula = fu_cedruc,
          @w_causa_bloqueo = fu_causa_bloqueo,
          @w_fecha_cargo_ant = fu_fecha_cargo
    FROM cl_funcionario
    WHERE fu_funcionario = @i_funcionario

    SELECT @v_nombre = @w_nombre,
          @v_sexo = @w_sexo,
          @v_dinero = @w_dinero,
          @v_nomina = @w_nomina,
          @v_departamento = @w_departamento,
          @ww_departamento = @w_departamento,
          @v_oficina = @w_oficina,
          @ww_oficina = @w_oficina,
          @v_cargo = @w_cargo,
          @ww_cargo = @w_cargo,
          @v_secuencial = @w_secuencial,
          @ww_secuencial = @w_secuencial,
          @v_jefe = @w_jefe,
          @v_nivel = @w_nivel,
          @v_clave = @w_clave,
          @v_offset = @w_offset,
          @v_estado = @w_estado,
          @v_login = @w_login,
          @v_cedula = @w_cedula,
          @v_causa_bloqueo = @w_causa_bloqueo

    IF ((@ww_departamento <> @i_departamento) OR 
      (@ww_oficina <> @i_oficina) OR 
      (@ww_cargo <> @i_cargo) OR 
      (@ww_secuencial <> @i_secuencial))
    BEGIN 
      SELECT @w_secuencial = ds_secuencial
      FROM cl_distributivo
      WHERE ds_departamento = @i_departamento
      AND ds_vacante = 'S'
      AND ds_oficina = @i_oficina 
      AND ds_cargo = @i_cargo
      AND ds_secuencial = @i_secuencial

      IF @@rowcount = 0
      BEGIN 
        EXEC sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 101051
              /* 'No existe vacante'*/
        RETURN 1
      END 
    END 

    IF @w_secuencial = @i_secuencial
      SELECT @w_secuencial = NULL, @v_secuencial = NULL 
    ELSE 
      SELECT  @v_secuencial = @w_secuencial

    IF @w_nombre = @i_nombre
      SELECT @w_nombre = NULL, @v_nombre = NULL 
    ELSE 
      SELECT @w_nombre = @i_nombre

    IF @w_login = @i_login
      SELECT @w_login = NULL, @v_login = NULL 
    ELSE 
      SELECT @w_login = @i_login

    IF @w_sexo = @i_sexo
      SELECT @w_sexo = NULL, @v_sexo = NULL
    ELSE 
      SELECT @w_sexo = @i_sexo
 
    IF @w_dinero = @i_dinero
      SELECT @w_dinero = NULL, @v_dinero = NULL 
    ELSE 
      SELECT @w_dinero = @i_dinero
 
    IF @w_nomina = @i_nomina
      SELECT @w_nomina = NULL, @v_nomina = NULL 
    ELSE 
      SELECT @w_nomina = @i_nomina

    IF @w_cedula = @i_cedula
      SELECT @w_cedula = NULL, @v_cedula = NULL 
    ELSE 
      SELECT @w_cedula = @i_cedula

    IF @w_causa_bloqueo = @i_causa_bloqueo
      SELECT @w_causa_bloqueo = NULL, @v_causa_bloqueo = NULL 
    ELSE 
      SELECT @w_causa_bloqueo = @i_causa_bloqueo

    /*** Verifica si es cambio de Password ***/
    /************ ADU: 24/04/2001 ************/
    IF @i_chpass='S'
    BEGIN 
      /************ ADU: 24/04/2001 ************/
      /*** ARO:18/01/2001 CRYPWD  ***/
      IF @w_clave = @i_clave
        SELECT @w_clave = NULL, @v_clave = NULL 
      ELSE 
        SELECT @w_clave = @i_clave

      IF @w_estado = @i_estado
        SELECT @w_estado = NULL, @v_estado = NULL 
      ELSE 
        SELECT @w_estado = @i_estado
 
      IF @w_offset = @t_offset
        SELECT @w_offset = NULL, @v_offset = NULL 
      ELSE 
        /*** ARO: 16 de Noviembre del 2000 ***/
        /****** CONTROL DE PASSWORDS REPETIDOS *****/
      BEGIN 
            SELECT @w_offset = @t_offset
        /*** Control  de Repeticion Historica de Passwords ***/
        /*** ARO: 16 de Noviembre ***/    
        SELECT @w_npch=isnull(pa_tinyint,0)
        FROM cl_parametro
        WHERE pa_producto='ADM' 
        AND pa_nemonico='NPCH'
     
        IF @@rowcount=0
        BEGIN 
          EXEC sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 151124
            /* No existe Parámetro General  */
          RETURN 1 
        END 
     
        DECLARE CUR_CLAVES CURSOR FOR 
        --   select ch_clave            ARO:18/01/2001 CRYPWD
        SELECT ch_offset
        FROM cl_clave_his
        WHERE ch_login=@i_login
        ORDER BY ch_secuencial DESC 
     
        OPEN CUR_CLAVES
     
        SELECT @w_contador_his=0
        --fetch CUR_CLAVES into @w_clave_his  ARO:18/01/2001 CRYPWD
        FETCH CUR_CLAVES INTO @w_offset_his  
     
        WHILE (@@fetch_status = 0) AND (@w_contador_his < @w_npch)   --sqlstatus: mig syb-sqls 11032016
        BEGIN 
          --    if @w_clave_his=@i_clave        ARO:18/01/2001 CRYPWD
              IF @w_offset_his=@t_offset
          BEGIN 
                EXEC sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 151125
                  /* No existe Parámetro General  */
                RETURN 1        
          END 
              
              SELECT @w_contador_his=@w_contador_his+1
          --fetch CUR_CLAVES into @w_clave_his  ARO:18/01/2001 CRYPWD
              FETCH CUR_CLAVES into @w_offset_his
        END 
      CLOSE CUR_CLAVES
      deallocate CUR_CLAVES
      /***** FIN ARO ****/

      /**** ARO: 16 de Noviembre del 2000 ***/
      /*** Control Historico de Passwords (evitar repeticiones) ****/
      SELECT @w_sec_his=isnull(max(ch_secuencial),0)+1
      FROM cl_clave_his
      WHERE ch_login=@i_login
    
      INSERT INTO cl_clave_his (
        ch_login,
        ch_secuencial,
        ch_fecha,
        -- ch_clave)    ARO:18/01/2001 CRYPWD
            ch_offset)
      VALUES (
        @i_login,
        @w_sec_his,
        getdate(),
        -- @i_clave)    ARO:18/01/2001 CRYPWD
            @t_offset)

      IF @@error != 0
      BEGIN 
            EXEC sp_cerror
              @t_debug      = @t_debug,
              @t_file       = @t_file,
              @t_from       = @w_sp_name,
              @i_num        = 153051
              /* 'Error en insercion en CL_CLAVE_HIS' */
            RETURN 1
      END 
      /***** FIN ARO ******/ 
    END 
    /**** FIN ARO ****/

  /************ ADU: 24/04/2001 ************/
  END 
  ELSE 
  BEGIN 
    SELECT @w_offset = NULL, @v_offset = NULL 
  END 
  /********** FIN ADU: 24/04/2001 **********/

  IF @w_departamento = @i_departamento AND @w_oficina = @i_oficina
  BEGIN 
        SELECT @w_departamento = NULL, @v_departamento = NULL 
        SELECT @w_oficina = NULL, @v_oficina = NULL 
  END 
  ELSE 
  BEGIN 
        SELECT @w_departamento = @i_departamento
        SELECT @w_oficina = @i_oficina
  END 
 
  IF @w_cargo = @i_cargo
  BEGIN
    SELECT @w_cargo = NULL, @v_cargo = NULL 
    SELECT @w_fecha_cargo = @w_fecha_cargo_ant
  END
  ELSE 
  BEGIN
    SELECT @w_cargo = @i_cargo
    SELECT @w_fecha_cargo = @s_date
  END
  
  IF @w_jefe= @i_jefe
  BEGIN 
    SELECT @w_jefe = NULL, @v_jefe = NULL 
    SELECT @w_nivel = NULL, @v_nivel = NULL 
  END 
  ELSE 
  BEGIN 
    SELECT @w_jefe = @i_jefe
    SELECT @w_nivel = @w_codigo
  END 

  BEGIN TRAN 
  /*** Verifica si es cambio de Password ***/
  /************ ADU: 24/04/2001 ************/
  IF @i_chpass='S'
  BEGIN 
    /************ ADU: 24/04/2001 ************/
    UPDATE cl_funcionario
    SET fu_nombre = @i_nombre,
          fu_sexo = @i_sexo,
          fu_dinero = @i_dinero,
          fu_nomina = @i_nomina, 
          fu_departamento = @i_departamento,
          fu_oficina = @i_oficina,
          fu_cargo = @i_cargo,
          fu_secuencial = @i_secuencial,
          fu_jefe = @i_jefe,
          fu_nivel = @w_codigo,
          fu_clave = @i_clave,
          fu_estado = @i_estado,
          fu_offset = @t_offset,        -- ARO:18/01/2001 CRYPWD
          fu_fec_inicio=getdate(),
          fu_cedruc = @i_cedula,
          fu_causa_bloqueo = @i_causa_bloqueo,
          fu_fecha_cargo = @w_fecha_cargo
    WHERE fu_funcionario = @i_funcionario
    IF @@error != 0
    BEGIN 
      EXEC sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 105044
          /* 'Error en actualizacion de funcionario'*/
      RETURN 1
    END 

        SELECT @w_dvpw = pa_tinyint
    FROM cobis.dbo.cl_parametro
    WHERE pa_nemonico = 'DVPW'
   
    UPDATE ad_usuario
       SET us_fecha_ult_mod = dateadd(day, -@w_dvpw,@s_date)
    WHERE  us_login = @i_login

    IF @@error != 0
    BEGIN 
          EXEC sp_cerror
            @t_debug      = @t_debug,
            @t_file       = @t_file,
            @t_from       = @w_sp_name,
            @i_num        = 155005
            /*  'Error en actualizacion de usuario' */
          RETURN 1
    END 

    /************ ADU: 24/04/2001 ************/
  END 
  ELSE 
  BEGIN 
    UPDATE cl_funcionario
    SET fu_nombre = @i_nombre,
          fu_sexo = @i_sexo,
          fu_dinero = @i_dinero,
          fu_nomina = @i_nomina, 
          fu_departamento = @i_departamento,
          fu_oficina = @i_oficina,
          fu_cargo = @i_cargo,
          fu_secuencial = @i_secuencial,
          fu_jefe = @i_jefe,
          fu_nivel = @w_codigo,
          fu_clave = fu_clave,
          fu_estado = @i_estado,
          fu_offset = fu_offset,
          fu_fec_inicio=getdate(),
          fu_cedruc = @i_cedula,
          fu_causa_bloqueo = @i_causa_bloqueo,
          fu_fecha_cargo   = @w_fecha_cargo
    WHERE  fu_funcionario = @i_funcionario
    IF @@error != 0
    BEGIN 
      EXEC sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 105044
            /* 'Error en actualizacion de funcionario'*/
      RETURN 1
    END 
  END 
  /********** FIN ADU: 24/04/2001 **********/

  /* 'Disponer de la vacante actualizada'*/ 
  UPDATE cl_distributivo
  SET ds_vacante = 'S'
  WHERE ds_departamento = @ww_departamento
  AND ds_oficina = @ww_oficina
  AND ds_cargo = @ww_cargo
  AND ds_secuencial = @ww_secuencial
  IF @@error != 0
  BEGIN 
        EXEC sp_cerror
          @t_debug        = @t_debug,
          @t_file         = @t_file,
          @t_from         = @w_sp_name,
          @i_num          = 105044
          /*'Error en actualizacion de funcionario'*/
        RETURN 1
  END 
  
  UPDATE cl_distributivo
  SET ds_vacante = 'N'
  WHERE ds_departamento = @i_departamento
  AND ds_oficina = @i_oficina
  AND ds_cargo = @i_cargo
  AND ds_secuencial = @i_secuencial

  /* transaccion de servicio - funcionario */
  INSERT INTO ts_funcionario (
     secuencia,      tipo_transaccion,   clase,         fecha,    oficina_s,
     usuario,        terminal_s,         srv,           lsrv,     login,
     funcionario,    nombre,             sexo,          dinero,   departamento,
     oficina,        cargo,              secuencia_f,   jefe,     nivel,
     nomina,         clave,              estado,        offset,   cedula,
    causa_bloqueo)
  VALUES (
     @s_ssn,           599 ,        'P',             @s_date,     @s_ofi, 
     @s_user,          @s_term,     @s_srv,          @s_lsrv,     @v_login, 
     @i_funcionario,   @v_nombre,   @v_sexo,         @v_dinero,   @v_departamento,
     @v_oficina,       @v_cargo,    @v_secuencial,   @v_jefe,     @v_nivel, 
     @v_nomina,        @v_clave,    @v_estado,       @v_offset,   @v_cedula,
     @v_causa_bloqueo)
  IF @@error != 0
  BEGIN 
    EXEC sp_cerror
          @t_debug        = @t_debug,
          @t_file         = @t_file,
          @t_from         = @w_sp_name,
          @i_num          = 103005
          /* 'Error en creacion de transaccion de servicio'*/
    RETURN 1
  END 
  
  INSERT INTO ts_funcionario (
     secuencia,     tipo_transaccion,   clase,         fecha,    oficina_s,
     usuario,       terminal_s,         srv,           lsrv,     login,
     funcionario,   nombre,             sexo,          dinero,   departamento,
     oficina,       cargo,              secuencia_f,   jefe,     nivel, 
     nomina,        clave,              estado,        offset,   cedula,
    causa_bloqueo)
  VALUES (
     @s_ssn,           599,         'A',             @s_date,     @s_ofi, 
     @s_user,          @s_term,     @s_srv,          @s_lsrv,     @w_login, 
     @i_funcionario,   @w_nombre,   @w_sexo,         @w_dinero,   @w_departamento, 
     @w_oficina,       @w_cargo,    @w_secuencial,   @w_jefe,     @w_nivel, 
     @w_nomina,        @w_clave,    @i_estado,       @w_offset,   @w_cedula,
     @w_causa_bloqueo)
  IF @@error != 0
  BEGIN 
    EXEC sp_cerror
          @t_debug        = @t_debug,
          @t_file         = @t_file,
          @t_from         = @w_sp_name,
          @i_num          = 103005
          /*'Error en creacion de transaccion de servicio'*/
    RETURN  1
  END 

  COMMIT TRAN 
 
  /************ ADU: 26/06/2001 ************/
  IF @i_chpass='S'
  BEGIN 
    --SELECT @w_cmdtransrv = @s_lsrv +'...sp_droplogin'
    SELECT @w_cmdtransrv = @s_lsrv +'...rp_tr_droplogin'   --migracion sqlserver 06052016
    
    /*EXEC @w_cmdtransrv
          @loginame = @i_login
    */
    --Migracion sqlserver 
    EXEC @w_cmdtransrv
          @i_loginame = @i_login
          
    --SELECT @w_cmdtransrv = @s_lsrv +'...sp_addlogin'
    SELECT @w_cmdtransrv = @s_lsrv +'...rp_tr_addlogin'     --migracion sqlserver 06052016
    
    /*EXEC @w_cmdtransrv
        @loginame = @i_login,
        @passwd   = @i_clave
     */
     
    --Migracion sqlserver 
    EXEC @w_cmdtransrv
          @i_loginame = @i_login,
          @i_password   = @i_clave          
        
  END 
  /********** FIN ADU: 26/06/2001 **********/

  /******************************* Para   Unix  **************************/

  INSERT INTO ad_nodo_reentry_tmp  -- #ad_nodo_reentry_tmp     Mario Vélez: 24/oct/2012
        SELECT nl_nombre,'N'
          FROM ad_nodo_oficina,ad_server_logico
         WHERE nl_nombre <> @s_lsrv
           AND nl_filial   = sg_filial_i
           AND nl_oficina  = sg_oficina_i
           AND nl_nodo     = sg_nodo_i
           AND sg_producto = 1
           AND sg_tipo     = 'R'
           AND sg_moneda   = 0

  SELECT @w_num_nodos = count(*) FROM ad_nodo_reentry_tmp   -- #ad_nodo_reentry_tmp     Mario Vélez: 24/oct/2012
  SELECT @w_contador = 1
  
  WHILE @w_contador <= @w_num_nodos
  BEGIN 
    SET ROWCOUNT 1
        SELECT @w_cmdtransrv = 'REENTRY' + '.' + nt_nombre + '.cobis.' +
                   @w_sp_name,@w_nt_nombre = nt_nombre
        FROM ad_nodo_reentry_tmp    -- #ad_nodo_reentry_tmp        Mario Vélez: 24/oct/2012
        WHERE nt_bandera = 'N'

    SET ROWCOUNT 0
--      UPDATE #ad_nodo_reentry_tmp  set  nt_bandera = 'S'             Mario Vélez: 24/oct/2012
        UPDATE ad_nodo_reentry_tmp  set  nt_bandera = 'S'
        WHERE nt_nombre  = @w_nt_nombre

    EXEC @w_return = @w_cmdtransrv
          @t_trn             = @t_trn,
          @i_operacion       = @i_operacion,
          @i_secuencial      = @i_secuencial,
          @i_funcionario     = @i_funcionario,
          @i_login           = @i_login,
          @i_clave           = @i_clave,
          @i_nombre          = @i_nombre,
          @i_sexo            = @i_sexo,
          @i_dinero          = @i_dinero,
          @i_nomina          = @i_nomina,
          @i_departamento    = @i_departamento,
          @i_oficina         = @i_oficina,
          @i_cargo           = @i_cargo,
          @i_jefe            = @i_jefe,
          @i_nivel           = @w_codigo,
          @i_estado          = @i_estado,
          @i_central_transmit = 'S',
          @o_clave           = @w_clave_int out

          IF @w_return <> 0
                RETURN @w_return

          EXEC @w_return = cobis..sp_reentry
                @i_key = @w_clave_int,
                @i_tipo = 'I'

          IF @w_return <> 0
                RETURN @w_return

          SELECT @w_contador = @w_contador + 1
          CONTINUE 
        END 
--      DELETE #ad_nodo_reentry_tmp         Mario Vélez: 24/oct/2012
        DELETE ad_nodo_reentry_tmp
        
    /******************************* Para   Unix  **************************/
 
    RETURN 0
  END 
  ELSE 
  BEGIN 
        EXEC sp_cerror
          @t_debug      = @t_debug,
          @t_file       = @t_file,
          @t_from       = @w_sp_name,
          @i_num        = 151051
          /*  'No corresponde codigo de transaccion' */
        RETURN 1
  END 
END 


/*** Delete ***/
IF @i_operacion = 'D'
BEGIN 
  IF @t_trn = 1510
  BEGIN 
    /* chequeo de referencias */
    IF NOT EXISTS ( 
      SELECT fu_funcionario
      FROM cl_funcionario
      WHERE fu_funcionario = @i_funcionario)
    BEGIN 
      EXEC sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 101036
            /* 'Funcionario no existe'*/
      RETURN 1
    END 

    IF EXISTS ( 
      SELECT fu_funcionario
      FROM cl_funcionario
      WHERE fu_jefe = @i_funcionario)
    BEGIN 
      EXEC sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 151058
            /* 'Existen funcionarios subalternos a este'*/
      RETURN 1
    END 

    SELECT @w_login = fu_login 
    FROM cl_funcionario
    WHERE fu_funcionario = @i_funcionario

    /* referencia en ad_usuario */
    IF EXISTS (
          SELECT us_login
          FROM ad_usuario
          WHERE us_login = @w_login
          )
    BEGIN 
          EXEC sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 101064
          /* Existe referencia en ad_usuario */
          RETURN 1
    END 

    /* referencia en ad_usuario_rol */
    IF EXISTS(
          SELECT ur_login
          FROM ad_usuario_rol
          WHERE ur_login = @w_login
          )
    BEGIN 
          EXEC sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 101063
            /* Existe referencia en ad_usuario_rol */
          RETURN 1
    END 

    /* referencia en cc_oficial */
    IF EXISTS(
          SELECT oc_funcionario
          FROM cc_oficial
          WHERE oc_funcionario = @i_funcionario
          )
    BEGIN 
          EXEC  sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 151090
            /* Oficial tiene subordinados, no puede eliminarse */
          RETURN 1
    END 

    /* referencia en cc_oficial */
    IF EXISTS(
          SELECT oc_funcionario
          FROM cc_oficial
          WHERE oc_funcionario = @i_funcionario
          )
    BEGIN 
          EXEC sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 151090
            /* Oficial tiene subordinados, no puede eliminarse */
          RETURN 1
    END 

    SELECT @w_funcionario = fu_funcionario,
          @w_nombre = fu_nombre,
          @w_sexo = fu_sexo,
          @w_dinero = fu_dinero,
          @w_nomina = fu_nomina,
          @w_departamento = fu_departamento,
          @w_oficina = fu_oficina,
          @w_cargo = fu_cargo,
          @w_secuencial = fu_secuencial,
          @w_jefe = fu_jefe,
          @w_nivel = fu_nivel,
          @w_clave = fu_clave,
          @w_offset = fu_offset,
          @w_cedula = fu_cedruc,
          @w_causa_bloqueo = fu_causa_bloqueo
    FROM cl_funcionario
    WHERE fu_funcionario = @i_funcionario

    BEGIN TRAN 
    
    DELETE cl_funcionario
    WHERE fu_funcionario = @i_funcionario
    IF @@error != 0
    BEGIN 
      EXEC sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 107046
            /*'Error en borrado de funcionario'*/
       RETURN 1
    END 

    UPDATE cl_distributivo
    SET ds_vacante = 'S'
    WHERE ds_departamento = @w_departamento
    AND ds_oficina = @w_oficina
    AND ds_cargo = @w_cargo
    AND ds_secuencial = @w_secuencial
    IF @@error != 0
    BEGIN 
      EXEC sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 107046
            /*'Error en borrado de funcionario'*/
      RETURN 1
    END 

    /* transaccion de servicio - funcionario */
    INSERT INTO ts_funcionario (
       secuencia,     tipo_transaccion,   clase,         fecha,    oficina_s, 
       usuario,       terminal_s,         srv,           lsrv,     login, 
       funcionario,   nombre,             sexo,          dinero,   departamento,
       oficina,       cargo,              secuencia_f,   jefe,     nivel, 
       nomina,        clave,              offset,        cedula,   causa_bloqueo)
    VALUES (
       @s_ssn,           1510,        'B',             @s_date,     @s_ofi, 
       @s_user,          @s_term,     @s_srv,          @s_lsrv,     @w_login, 
       @w_funcionario,   @w_nombre,   @w_sexo,         @w_dinero,   @w_departamento,
       @w_oficina,       @w_cargo,    @w_secuencial,   @w_jefe,     @w_nivel, 
       @w_nomina,        @w_clave,    @w_offset,       @w_cedula,   @w_causa_bloqueo)
    IF @@error != 0
    BEGIN 
      EXEC sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 103005
            /*'Error en creacion de transaccion de servicio'*/
      RETURN 1
    END  
 
    commit tran
   
    /*SELECT @w_cmdtransrv = @s_lsrv +'...sp_droplogin'
    EXEC @w_cmdtransrv
        @loginame = @i_login
    */  --migracion sqlserver 06052016
    
    --migracion sqlserver 06052016
    SELECT @w_cmdtransrv = @s_lsrv +'...rp_tr_droplogin'   
    
    EXEC @w_cmdtransrv
          @i_loginame = @i_login
    --migracion sqlserver 06052016
        
    /******************************* Para   Unix  **************************/

        INSERT INTO ad_nodo_reentry_tmp    -- #ad_nodo_reentry_tmp       Mario Vélez: 24/oct/2012
        SELECT nl_nombre,'N'
          FROM ad_nodo_oficina,ad_server_logico
         WHERE nl_nombre <> @s_lsrv
           AND nl_filial   = sg_filial_i
           AND nl_oficina  = sg_oficina_i
           AND nl_nodo     = sg_nodo_i
           AND sg_producto = 1
           AND sg_tipo     = 'R'
           AND sg_moneda   = 0

        SELECT @w_num_nodos = count(*) FROM ad_nodo_reentry_tmp     -- #ad_nodo_reentry_tmp           Mario Vélez: 24/oct/2012
        SELECT @w_contador = 1
        
        WHILE @w_contador <= @w_num_nodos
        BEGIN 
          SET ROWCOUNT 1
          SELECT @w_cmdtransrv = 'REENTRY' + '.' + nt_nombre + '.cobis.' +
        @w_sp_name,@w_nt_nombre = nt_nombre
          FROM ad_nodo_reentry_tmp   -- #ad_nodo_reentry_tmp               Mario Vélez: 24/oct/2012
          WHERE nt_bandera = 'N'

          SET ROWCOUNT 0
--        UPDATE #ad_nodo_reentry_tmp  SET nt_bandera = 'S'                    Mario Vélez: 24/oct/2012
          UPDATE ad_nodo_reentry_tmp  SET nt_bandera = 'S'
          WHERE nt_nombre  = @w_nt_nombre

          EXEC @w_return = @w_cmdtransrv
                @t_trn             = @t_trn,
                @i_operacion       = @i_operacion,
                @i_funcionario     = @i_funcionario,
                @i_central_transmit = 'S',
                @o_clave           = @w_clave_int out

          IF @w_return <> 0
                RETURN @w_return

          EXEC @w_return = cobis..sp_reentry
                @i_key = @w_clave_int,
                @i_tipo = 'I'

          IF @w_return <> 0
                RETURN @w_return

          SELECT @w_contador = @w_contador + 1
          CONTINUE 
        END 
--      DELETE #ad_nodo_reentry_tmp              Mario Vélez: 24/oct/2012
        DELETE ad_nodo_reentry_tmp
        
    /******************************* Para   Unix  **************************/
    
    RETURN 0
  END 
  ELSE 
  BEGIN 
        EXEC sp_cerror
          @t_debug      = @t_debug,
          @t_file       = @t_file,
          @t_from       = @w_sp_name,
          @i_num        = 151051
          /* 'No corresponde codigo de transaccion' */
        RETURN 1
  END 
END 

/* LLamada al stored procedure sp_cons_funcionario */
/* para operaciones de consulta                    */

IF @i_operacion = 'S' OR @i_operacion = 'Q' OR @i_operacion = 'H'
BEGIN 
  EXEC @w_return = sp_cons_funcionario
    @t_file                 = @t_file,
        @t_from                 = @t_from,
        @t_trn                  = @t_trn,
        @i_operacion            = @i_operacion,
        @i_tipo                 = @i_tipo,
        @i_modo                 = @i_modo,
        @i_funcionario          = @i_funcionario, 
        @i_nombre               = @i_nombre,    
        @i_login                = @i_login
        /*  @i_estado               = @i_estado   RLA 2000-feb-16 */
  IF @w_return != 0
        RETURN @w_return
END  
GO 
