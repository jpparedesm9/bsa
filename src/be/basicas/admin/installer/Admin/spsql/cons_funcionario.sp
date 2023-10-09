/************************************************************************/
/*   Archivo:          cons_funcionario.sp                              */
/*   Stored procedure:   sp_cons_funcionario                            */
/*   Base de datos:      cobis                                          */
/*   Producto:           Clientes                                       */
/*   Disenado por:       Mauricio Bayas/Sandra Ortiz                    */
/*   Fecha de escritura:   12/Abr/94                                    */
/************************************************************************/
/*            IMPORTANTE                                                */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA", representantes exclusivos para el Ecuador de la          */
/*   "NCR CORPORATION".                                                 */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/*            PROPOSITO                                                 */
/*   Este programa procesa las transacciones del stored procedure       */
/*   Busqueda de funcionario                                            */
/*   Query de funcionario                                               */
/*   Help de funcionario                                                */
/*            MODIFICACIONES                                            */
/*   FECHA      AUTOR      RAZON                                        */
/*   12/Abr/94   F.Espinosa   Emision inicial                           */   
/*   25/Abr/94   F.Espinosa   Parametros tipo "S"                       */
/*                       Transacciones de Servicio                      */
/*  06/Jun/12   D. Vera     Cambio tipo dato smallint a int en campo    */
/*                          nomina                                      */
/************************************************************************/
use cobis
GO 

IF EXISTS (SELECT * from sysobjects where name = 'sp_cons_funcionario')
   drop proc sp_cons_funcionario
go

create proc sp_cons_funcionario (
   @s_ssn            int = NULL,
   @s_user           login = NULL,
   @s_sesn           int = NULL,
   @s_term           varchar(32) = NULL,
   @s_date           datetime = NULL,
   @s_srv            varchar(30) = NULL,
   @s_lsrv           varchar(30) = NULL, 
   @s_rol            smallint = NULL,
   @s_ofi            smallint = NULL,
   @s_org_err        char(1) = NULL,
   @s_error          int = NULL,
   @s_sev            tinyint = NULL,
   @s_msg            descripcion = NULL,
   @s_org            char(1) = NULL,
   @t_debug          char(1) = 'N',
   @t_file           varchar(14) = null,
   @t_from           varchar(32) = null,
   @t_trn            smallint = null,
   @i_operacion      char(1),
   @i_modo           tinyint = NULL,
   @i_tipo           char(1) = NULL,
   @i_funcionario    smallint = NULL,
   @i_nombre         descripcion = NULL,
    @i_login         varchar(30) = NULL,
   @i_sexo           sexo = NULL,
   @i_nomina         int = NULL, -- DVE cambio de smallint a int
   @i_dinero         char(1) = 'N',
   @i_departamento   smallint = NULL,
   @i_cargo          tinyint = NULL,
    @i_secuencial    tinyint = NULL,
   @i_jefe           smallint = NULL,
   @o_siguiente      int = NULL out

)
as
declare @w_today   datetime,
   @w_sp_name        varchar(32),
   @o_funcionario    smallint,
   @o_nombre         descripcion,
   @o_login          varchar(30),
   @o_sexo           sexo,
   @o_senombre       descripcion,
   @o_dinero         char(1),
   @o_nomina         int, --DVE cambio de smallint a int
   @o_departamento   smallint,
   @o_denombre       descripcion,
   @o_oficina        smallint,
   @o_ofinombre      descripcion,
   @o_cargo          tinyint,
   @o_canombre       descripcion,
   @o_secuencial     tinyint,
   @o_jefe           smallint,
   @o_jenombre       descripcion,
   @o_nivel          tinyint,
   @o_clave          varchar(30),
   @o_estado         varchar(1),
   @o_cedula         varchar(30),
   @o_causa_bloqueo  catalogo

select @w_today = @s_date
select @w_sp_name = 'sp_cons_funcionario'

--QUERY
if @i_operacion = 'Q'
   begin
      if @t_trn = 1575
         begin
            select  @o_jenombre = fu_nombre
            from  cl_funcionario
            where  fu_funcionario = (select fu_jefe
            from cl_funcionario
            where fu_funcionario = @i_funcionario)

            select  @o_funcionario = fu_funcionario,
               @o_nombre = fu_nombre,
               @o_login  = fu_login,
               @o_sexo = fu_sexo,
               @o_dinero = fu_dinero,
               @o_nomina = fu_nomina,
               @o_departamento = fu_departamento,
               @o_denombre = de_descripcion,
               @o_oficina = fu_oficina,
               @o_ofinombre = of_nombre,
               @o_cargo = fu_cargo,
               @o_canombre = w.valor,
               @o_secuencial = fu_secuencial,
               @o_jefe = fu_jefe,
               @o_estado = fu_estado,
               @o_clave = fu_clave,
               @o_cedula = fu_cedruc,
               @o_causa_bloqueo = fu_causa_bloqueo
            from   cl_funcionario, cl_departamento, 
               cl_oficina, cl_catalogo w, cl_tabla z
            where  fu_funcionario = @i_funcionario
            and    de_departamento = fu_departamento
            and    de_oficina = fu_oficina
            and    of_oficina = fu_oficina 
            and    w.codigo = convert(char(10),fu_cargo)
            and    w.tabla = z.codigo
            and    z.tabla = 'cl_cargo'
            order  by fu_funcionario

            if @@rowcount = 0
               begin
                  exec sp_cerror
                     @t_debug   = @t_debug,
                     @t_file      = @t_file,
                     @t_from      = @w_sp_name,
                     @i_num      = 101036
                     --NO EXISTE FUNCIONARIO
                  return 1
               end

            if (@o_sexo = 'F')
               select @o_senombre = 'FEMENINO'
            else
               select @o_senombre = 'MASCULINO'

            select @o_funcionario, @o_nombre, @o_sexo, @o_senombre, @o_dinero,
               @o_departamento,@o_denombre, @o_cargo, @o_canombre, @o_secuencial,
               @o_jefe, @o_jenombre, @o_login, @o_nomina, @o_oficina, 
               @o_ofinombre, @o_clave, @o_estado, @o_cedula, @o_causa_bloqueo
            return 0
         end
      else
         begin
            exec sp_cerror
               @t_debug    = @t_debug,
               @t_file    = @t_file,
               @t_from    = @w_sp_name,
               @i_num    = 151051
               --NO CORRESPONDE CODIGO DE TRANSACCION
            return 1
         end
   end

--HELP
if @i_operacion = 'H'
   begin
      if @t_trn = 1577
         begin
            if @i_tipo = 'A'
               begin
                  set rowcount 20
                  if @i_modo = 0
                     begin
                        select "Cod." = fu_funcionario,
                           "Trabajador" = fu_nombre
                        from   cl_funcionario
                        where  fu_funcionario > 0
                        order  by fu_funcionario

                        if @@rowcount = 0
                           exec sp_cerror
                              @t_debug   = @t_debug,
                              @t_file      = @t_file,
                              @t_from      = @w_sp_name,
                              @i_num      = 101036
                              --NO EXISTE FUNCIONARIO
                     end

                  if @i_modo = 1
                     begin
                        select "Cod." = fu_funcionario, 
                           "Trabajador" = fu_nombre
                        from cl_funcionario
                        where fu_funcionario > @i_funcionario

                        if @@rowcount = 0
                           exec sp_cerror
                              @t_debug      = @t_debug,
                              @t_file       = @t_file,
                              @t_from       = @w_sp_name,
                              @i_num        = 101036
                              --NO EXISTE FUNCIONARIO
                     end
                  set rowcount 0
               end

               if @i_tipo = 'V'
                  begin
                     select fu_nombre,
                        fu_nivel
                     from   cl_funcionario
                     where  fu_funcionario = @i_funcionario

                     if @@rowcount = 0
                        exec sp_cerror
                           @t_debug   = @t_debug,
                           @t_file      = @t_file,
                           @t_from      = @w_sp_name,
                           @i_num      = 101036
                           --NO EXISTE FUNCIONARIO
                  end

               if @i_tipo = 'L'
                  begin
                     select fu_funcionario,
                        fu_nombre
                     from   cl_funcionario
                     where  fu_login = @i_login

                     if @@rowcount = 0
                        exec sp_cerror
                           @t_debug   = @t_debug,
                           @t_file      = @t_file,
                           @t_from      = @w_sp_name,
                           @i_num      = 101036
                           --NO EXISTE FUNCIONARIO
                  end
               return 0
         end
      else
         begin
            exec sp_cerror
               @t_debug    = @t_debug,
               @t_file    = @t_file,
               @t_from    = @w_sp_name,
               @i_num    = 151051
               --NO CORRESPONDE CODIGO DE TRANSACCION
            return 1
         end
   end

--SEARCH
if @i_operacion = 'S'
   begin
      if @t_trn = 1576
         begin
            set rowcount 20
            if @i_modo = 0
               select 'Codigo' = fu_funcionario,
                  'Trabajador' = substring(fu_nombre,1, 30),
                  'Login' = fu_login,
                  'Cargo' = substring(a.valor, 1, 30),
                  'Departamento' = substring(de_descripcion, 1, 30),
                  'Localidad ' = substring(of_nombre, 1, 30),
                  'Nomina' = fu_nomina
               from   cl_funcionario, cl_departamento, cl_catalogo a,
                  cl_tabla m, cl_oficina
               where  de_departamento = fu_departamento
               and    de_oficina = fu_oficina
               and    of_oficina = fu_oficina
               and    a.codigo = convert(char(10),fu_cargo)
               and    a.tabla  = m.codigo
               and    m.tabla  = 'cl_cargo'
               and    fu_funcionario > 0
               order  by fu_funcionario
            else
               select 'Codigo' = fu_funcionario,
                  'Trabajador' = substring(fu_nombre, 1, 30),
                  'Login' = fu_login,
                  'Cargo' = substring(a.valor, 1, 30),
                  'Departamento' = substring(de_descripcion, 1, 30),
                  'Localidad' = substring(of_nombre, 1, 30),
                  'Nomina' = fu_nomina
               from   cl_funcionario, cl_departamento, cl_catalogo a,
                  cl_tabla m, cl_oficina
               where  fu_funcionario > @i_funcionario
               and    de_departamento = fu_departamento
               and    de_oficina = fu_oficina
               and    of_oficina = fu_oficina
               and    a.codigo = convert(char(10),fu_cargo)
               and    a.tabla  = m.codigo
               and    m.tabla  = 'cl_cargo'
               order  by fu_funcionario

               if @@rowcount = 0
                  begin
                     exec sp_cerror
                        @t_debug   = @t_debug,
                        @t_file      = @t_file,
                        @t_from      = @w_sp_name,
                        @i_num      = 101036
                        --NO EXISTE FUNCIONARIO
                     set rowcount 0
                     return 1
                  end

               set rowcount 0
               return 0
         end
      else
         begin
            exec sp_cerror
               @t_debug    = @t_debug,
               @t_file    = @t_file,
               @t_from    = @w_sp_name,
               @i_num    = 151051
               --No corresponde codigo de transaccion
            return 1
         end
   end
go
