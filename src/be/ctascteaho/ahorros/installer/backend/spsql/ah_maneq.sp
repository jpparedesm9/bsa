/************************************************************************/
/*   Archivo:            ah_maneq.sp                                    */
/*   Stored procedure:   sp_mant_equiv                                  */
/*   Base de datos:      cobis                                          */
/*   Producto:           AHORROS                                        */
/*   Fecha de escritura: Jul. 2014                                      */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno  de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales de propiedad inte-         */
/*   lectual. Su uso no  autorizado dara  derecho a COBISCorp para      */
/*   obtener ordenes  de secuestro o  retencion y para  perseguir       */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                          PROPOSITO                                   */
/*                                                                      */
/*   Procedimiento que utiliza la pantalla del producto de Ahorros      */
/*   para el mantenimiento de equivalencias                             */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*   FECHA            AUTOR             RAZON                           */
/*   Julio-13-2015    Cesar Masabanda   Emision Inicial                 */
/*   04/May/2016      J. Salazar        Migracion COBIS CLOUD MEXICO    */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_mant_equiv')
  drop proc sp_mant_equiv
go

/****** Object:  StoredProcedure [dbo].[sp_mant_equiv]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_mant_equiv
(
  @s_ssn          int = null,
  @s_date         datetime = null,
  @s_user         login = null,
  @s_term         descripcion = null,
  @s_corr         char(1) = null,
  @s_ssn_corr     int = null,
  @s_ofi          smallint = null,
  @s_lsrv         varchar(30) = null,
  @s_srv          varchar(30) = null,
  @t_rty          char(1) = null,
  @t_trn          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(30) = null,
  @t_show_version bit = 0,
  @i_operacion    char(1) = null,
  @i_modo         smallint = 0,
  @i_siguiente    int = 0,
  @i_modulo       tinyint = null,
  @i_mod_int      tinyint = null,
  @i_tabla        varchar(16) = null,
  @i_val_cfijo    varchar(10) = null,
  @i_val_num_ini  varchar(30) = null,
  @i_val_num_fin  varchar(30) = null,
  @i_val_interfaz varchar(10) = null,
  @i_descripcion  varchar(64) = null
)
as
  declare
    @w_sp_name      varchar(32),
    @w_existe       tinyint,
    @w_modulo       tinyint,
    @w_mod_int      tinyint,
    @w_tabla        varchar(16),
    @w_val_cfijo    varchar(10),
    @w_val_num_ini  varchar(30),
    @w_val_num_fin  varchar(30),
    @w_val_interfaz varchar(10),
    @w_descripcion  varchar(64),
    @w_valor_cat    varchar(30),
    @cont           tinyint

  select
    @w_sp_name = 'sp_mant_equiv',
    @cont = 0

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  -- Codigos de Transacciones                                
  if (@t_trn <> 4165
      and @i_operacion = 'I')
      or (@t_trn <> 4166
          and @i_operacion = 'U')
      or (@t_trn <> 4164
          and @i_operacion = 'S')
      or (@t_trn <> 4167
          and @i_operacion = 'D')
  begin
    --- Codigo de Transaccion No Valido
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251034
    return 1
  end

  -- Chequeo de Existencias 
  if @i_operacion <> 'S'
  begin
    if @i_operacion = 'I'
    begin
      select
        @w_tabla = eq_tabla,
        @w_val_cfijo = eq_val_cfijo,
        @w_val_num_ini = eq_val_num_ini,
        @w_val_num_fin = eq_val_num_fin,
        @w_val_interfaz = eq_val_interfaz,
        @w_descripcion = eq_descripcion
      from   cob_remesas..re_equivalencias
      where  (eq_tabla        = @i_tabla
               or @i_tabla is null)
         and (eq_modulo       = @i_modulo
               or @i_modulo is null)
         and (eq_mod_int      = @i_mod_int
               or @i_mod_int is null)
         and (eq_val_cfijo    = @i_val_cfijo
               or @i_val_cfijo is null)
         and (eq_val_interfaz = @i_val_interfaz
               or @i_val_interfaz is null)
    end
    else
    begin
      select
        @w_tabla = eq_tabla,
        @w_val_cfijo = eq_val_cfijo,
        @w_val_num_ini = eq_val_num_ini,
        @w_val_num_fin = eq_val_num_fin,
        @w_val_interfaz = eq_val_interfaz,
        @w_descripcion = eq_descripcion
      from   cob_remesas..re_equivalencias
      where  (eq_tabla     = @i_tabla
               or @i_tabla is null)
         and (eq_modulo    = @i_modulo
               or @i_modulo is null)
         and (eq_mod_int   = @i_mod_int
               or @i_mod_int is null)
         and (eq_val_cfijo = @i_val_cfijo
               or @i_val_cfijo is null)
    end
    if @@rowcount > 0
      select
        @w_existe = 1
    else
      select
        @w_existe = 0
  end

  -- VALIDACION DE CAMPOS NULOS 
  if @i_operacion = 'I'
      or @i_operacion = 'U'
  begin
    if @i_modulo is null
        or @i_mod_int is null
        or @i_tabla is null
        or @i_val_cfijo is null
        or @i_val_interfaz is null
        or @i_descripcion is null
    begin
      --- CAMPOS OBLIGATORIOS VACIOS
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 263502
      return 1
    end

  end

  --- Insercion del registro 
  if @i_operacion = 'I'
  begin
    if @w_existe = 1
    begin
      --REGISTRO YA EXISTE PARA LOS DATOS COBIS INDICADOS 
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 263501
      return 1
    end

    -- VALIDACION DE CODIGO COBIS EN TABLA
    if exists (select
                 1
               from   cob_remesas..re_equivalencias
               where  eq_val_cfijo    = @i_val_cfijo
                  and eq_tabla        = @i_tabla
                  and eq_val_interfaz = @i_val_interfaz)
    --- LA TABLA EQUIVALENCIA YA TIENE ESE CODIGO COBIS
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251115
      return 1
    end

    -- VALIDACION DE CODIGO EXTERNO EN TABLA
    if exists (select
                 1
               from   cob_remesas..re_equivalencias
               where  eq_val_interfaz = @i_val_interfaz
                  and eq_tabla        = @i_tabla)
    --- LA TABLA EQUIVALENCIA YA TIENE ESE CODIGO EXTERNO
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251116
      return 1
    end

    goto VALIDAR_CATALOGO

    CATALOGOVALIDADOI:
    begin tran
    insert into cob_remesas..re_equivalencias
                (eq_modulo,eq_mod_int,eq_tabla,eq_val_cfijo,eq_val_num_ini,
                 eq_val_num_fin,eq_val_interfaz,eq_descripcion)
    values      ( @i_modulo,@i_mod_int,@i_tabla,@i_val_cfijo,@i_val_num_ini,
                  @i_val_num_fin,@i_val_interfaz,@i_descripcion )

    if @@error <> 0
    begin
      -- ERROR EN INSERCION DE REGISTRO 
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 263500
      return 1
    end

    --**** TRANSACCION DE SERVICIO ***
    insert into cob_remesas..re_tran_servicio
                (ts_secuencial,ts_tipo_transaccion,ts_clase,ts_tsfecha,
                 ts_operador
                 ,
                 ts_terminal,ts_oficina,ts_varchar6,ts_varchar2,
                 ts_varchar3,
                 ts_tinyint1,ts_tinyint2,ts_varchar4,ts_varchar5,ts_varchar1,
                 ts_varchar7,ts_varchar8,ts_varchar9,ts_datetime1)
    values      (@s_ssn,@t_trn,'N',@s_date,@s_user,
                 @s_term,@s_ofi,'re_equivalencias',@s_lsrv,@s_srv,
                 @i_modulo,@i_mod_int,@i_tabla,@i_val_cfijo,@i_val_num_ini,
                 @i_val_num_fin,@i_val_interfaz,@i_descripcion,getdate())

    if @@error <> 0
    begin
      --- ERROR EN INSERCION DE TRANSACCION DE SERVICIO 
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 253004
      return 1
    end

    commit tran
    goto LLENAR_GRILLA
  end

  --- Actualizacion del registro 
  if @i_operacion = 'U'
  begin
    if @w_existe = 0
    begin
      -- Registro a actualizar no existe 
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 276004
      return 1
    end

    -- VALIDACION DE CODIGO EXTERNO EN TABLA
    --  if exists (select 1 
    --                 from cob_remesas..re_equivalencias 
    --                 where eq_val_interfaz = @i_val_interfaz 
    --                 and   eq_tabla        = @i_tabla)

    ----- LA TABLA EQUIVALENCIA YA TIENE ESE CODIGO EXTERNO
    --  begin
    --    exec cobis..sp_cerror
    --    @t_debug = @t_debug,
    --    @t_file  = @t_file, 
    --    @t_from  = @w_sp_name,
    --    @i_num   = 251116
    --    return 1 
    --  end

    ---Seleccionar los valores anteriores
    select
      @w_tabla = eq_tabla,
      @w_val_cfijo = eq_val_cfijo,
      @w_val_num_ini = eq_val_num_ini,
      @w_val_num_fin = eq_val_num_fin,
      @w_val_interfaz = eq_val_interfaz,
      @w_descripcion = eq_descripcion,
      @w_modulo = eq_modulo,
      @w_mod_int = eq_mod_int
    from   cob_remesas..re_equivalencias
    where  (eq_tabla        = @i_tabla
             or @i_tabla is null)
       and (eq_modulo       = @i_modulo
             or @i_modulo is null)
       and (eq_mod_int      = @i_mod_int
             or @i_mod_int is null)
       and (eq_val_cfijo    = @i_val_cfijo
             or @i_val_cfijo is null)
       and (eq_val_num_ini  = @i_val_num_ini
             or @i_val_num_ini is null)
       and (eq_val_num_fin  = @i_val_num_fin
             or @i_val_num_fin is null)
       and (eq_val_interfaz = @i_val_interfaz
             or @i_val_interfaz is null)
       and (eq_descripcion  = @i_descripcion
             or @i_descripcion is null)

    goto VALIDAR_CATALOGO

    CATALOGOVALIDADOU:

    begin tran
    --**** TRANSACCION DE SERVICIO ANTES***
    insert into cob_remesas..re_tran_servicio
                (ts_secuencial,ts_tipo_transaccion,ts_clase,ts_tsfecha,
                 ts_operador
                 ,
                 ts_terminal,ts_oficina,ts_varchar6,ts_varchar2,
                 ts_varchar3,
                 ts_tinyint1,ts_tinyint2,ts_varchar4,ts_varchar5,ts_varchar1,
                 ts_varchar7,ts_varchar8,ts_varchar9,ts_datetime1)
    values      (@s_ssn,@t_trn,'P',@s_date,@s_user,
                 @s_term,@s_ofi,'re_equivalencias',@s_lsrv,@s_srv,
                 @w_modulo,@w_mod_int,@w_tabla,@w_val_cfijo,@w_val_num_ini,
                 @w_val_num_fin,@w_val_interfaz,@w_descripcion,getdate())

    if @@error <> 0
    begin
      --- ERROR EN INSERCION DE TRANSACCION DE SERVICIO 
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 253004
      return 1
    end

    update cob_remesas..re_equivalencias
    set    eq_tabla = @i_tabla,
           eq_val_cfijo = @i_val_cfijo,
           eq_val_num_ini = @i_val_num_ini,
           eq_val_num_fin = @i_val_num_fin,
           eq_val_interfaz = @i_val_interfaz,
           eq_descripcion = @i_descripcion,
           eq_modulo = @i_modulo,
           eq_mod_int = @i_mod_int
    where  (eq_tabla        = @w_tabla
             or @w_tabla is null)
       and (eq_modulo       = @w_modulo
             or @w_modulo is null)
       and (eq_mod_int      = @w_mod_int
             or @w_mod_int is null)
       and (eq_val_cfijo    = @w_val_cfijo
             or @w_val_cfijo is null)
       and (eq_val_num_ini  = @w_val_num_ini
             or @w_val_num_ini is null)
       and (eq_val_num_fin  = @w_val_num_fin
             or @w_val_num_fin is null)
       and (eq_val_interfaz = @w_val_interfaz
             or @w_val_interfaz is null)
       and (eq_descripcion  = @w_descripcion
             or @w_descripcion is null)

    if @@error <> 0
    begin
      --- ERROR AL ACTUALIZAR EL REGISTRO
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 276005
      return 1
    end

    --**** TRANSACCION DE SERVICIO DESPUES***
    ---Seleccionar los valores anteriores
    select
      @w_tabla = eq_tabla,
      @w_val_cfijo = eq_val_cfijo,
      @w_val_num_ini = eq_val_num_ini,
      @w_val_num_fin = eq_val_num_fin,
      @w_val_interfaz = eq_val_interfaz,
      @w_descripcion = eq_descripcion,
      @w_modulo = eq_modulo,
      @w_mod_int = eq_mod_int
    from   cob_remesas..re_equivalencias
    where  (eq_tabla        = @w_tabla
             or @w_tabla is null)
       and (eq_modulo       = @w_modulo
             or @w_modulo is null)
       and (eq_mod_int      = @w_mod_int
             or @w_mod_int is null)
       and (eq_val_cfijo    = @w_val_cfijo
             or @w_val_cfijo is null)
       and (eq_val_num_ini  = @w_val_num_ini
             or @w_val_num_ini is null)
       and (eq_val_num_fin  = @w_val_num_fin
             or @w_val_num_fin is null)
       and (eq_val_interfaz = @w_val_interfaz
             or @w_val_interfaz is null)
       and (eq_descripcion  = @w_descripcion
             or @w_descripcion is null)

    insert into cob_remesas..re_tran_servicio
                (ts_secuencial,ts_tipo_transaccion,ts_clase,ts_tsfecha,
                 ts_operador
                 ,
                 ts_terminal,ts_oficina,ts_varchar6,ts_varchar2,
                 ts_varchar3,
                 ts_tinyint1,ts_tinyint2,ts_varchar4,ts_varchar5,ts_varchar1,
                 ts_varchar7,ts_varchar8,ts_varchar9,ts_datetime1)
    values      (@s_ssn,@t_trn,'N',@s_date,@s_user,
                 @s_term,@s_ofi,'re_equivalencias',@s_lsrv,@s_srv,
                 @w_modulo,@w_mod_int,@w_tabla,@w_val_cfijo,@w_val_num_ini,
                 @w_val_num_fin,@w_val_interfaz,@w_descripcion,getdate())

    if @@error <> 0
    begin
      --- ERROR EN INSERCION DE TRANSACCION DE SERVICIO 
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 253004
      return 1
    end

    commit tran
    goto LLENAR_GRILLA
  end

  --- Eliminacion de registros 

  if @i_operacion = 'D'
  begin
    if @w_existe = 0
    begin
      --- REGISTRO NO EXISTE 
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 288504
      return 1
    end

    ---Seleccionar los valores
    select
      @w_tabla = eq_tabla,
      @w_val_cfijo = eq_val_cfijo,
      @w_val_num_ini = eq_val_num_ini,
      @w_val_num_fin = eq_val_num_fin,
      @w_val_interfaz = eq_val_interfaz,
      @w_descripcion = eq_descripcion,
      @w_modulo = eq_modulo,
      @w_mod_int = eq_mod_int
    from   cob_remesas..re_equivalencias
    where  (eq_tabla        = @i_tabla
             or @i_tabla is null)
       and (eq_modulo       = @i_modulo
             or @i_modulo is null)
       and (eq_mod_int      = @i_mod_int
             or @i_mod_int is null)
       and (eq_val_cfijo    = @i_val_cfijo
             or @i_val_cfijo is null)
       and (eq_val_num_ini  = @i_val_num_ini
             or @i_val_num_ini is null)
       and (eq_val_num_fin  = @i_val_num_fin
             or @i_val_num_fin is null)
       and (eq_val_interfaz = @i_val_interfaz
             or @i_val_interfaz is null)
       and (eq_descripcion  = @i_descripcion
             or @i_descripcion is null)

    begin tran
    delete cob_remesas..re_equivalencias
    where  (eq_tabla        = @w_tabla
             or @w_tabla is null)
       and (eq_modulo       = @w_modulo
             or @w_modulo is null)
       and (eq_mod_int      = @w_mod_int
             or @w_mod_int is null)
       and (eq_val_cfijo    = @w_val_cfijo
             or @w_val_cfijo is null)
       and (eq_val_num_ini  = @w_val_num_ini
             or @w_val_num_ini is null)
       and (eq_val_num_fin  = @w_val_num_fin
             or @w_val_num_fin is null)
       and (eq_val_interfaz = @w_val_interfaz
             or @w_val_interfaz is null)
       and (eq_descripcion  = @w_descripcion
             or @w_descripcion is null)

    if @@error <> 0
    begin
      ---ERROR EN ELIMINACION DE REGISTRO 
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 288503
      return 1
    end

    --**** TRANSACCION DE SERVICIO ***
    insert into cob_remesas..re_tran_servicio
                (ts_secuencial,ts_tipo_transaccion,ts_clase,ts_tsfecha,
                 ts_operador
                 ,
                 ts_terminal,ts_oficina,ts_varchar6,ts_varchar2,
                 ts_varchar3,
                 ts_tinyint1,ts_tinyint2,ts_varchar4,ts_varchar5,ts_varchar1,
                 ts_varchar7,ts_varchar8,ts_varchar9,ts_datetime1)
    values      (@s_ssn,@t_trn,'B',@s_date,@s_user,
                 @s_term,@s_ofi,'re_equivalencias',@s_lsrv,@s_srv,
                 @w_modulo,@w_mod_int,@w_tabla,@w_val_cfijo,@w_val_num_ini,
                 @w_val_num_fin,@w_val_interfaz,@w_descripcion,getdate())

    if @@error <> 0
    begin
      --- ERROR EN INSERCION DE TRANSACCION DE SERVICIO 
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 253004
      return 1
    end

    commit tran
    return 0
  end

  --- Consulta 
  if @i_operacion = 'S'
  begin
    if (@i_val_cfijo is not null)
    begin
      if not exists (select
                       1
                     from   cob_remesas..re_equivalencias
                     where  eq_val_cfijo = @i_val_cfijo
                        and (eq_tabla     = @i_tabla
                              or @i_tabla is null))
      --- NO EXISTE HOMOLOGACION PARA EL CODIGO INGRESADO
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251114
        return 1
      end
    end

    LLENAR_GRILLA:
    select
      eq_modulo,
      eq_mod_int,
      c.codigo eq_cod_tabla,
      eq_tabla,
      eq_val_cfijo,
      eq_val_num_ini,
      eq_val_num_fin,
      eq_val_interfaz,
      eq_descripcion
    into   #equivalencias
    from   cob_remesas..re_equivalencias,
           cobis..cl_catalogo c,
           cobis..cl_tabla t
    where  (eq_tabla        = @i_tabla
             or @i_tabla is null)
       and (eq_modulo       = @i_modulo
             or @i_modulo is null)
       and (eq_mod_int      = @i_mod_int
             or @i_mod_int is null)
       and (eq_val_cfijo    = @i_val_cfijo
             or @i_val_cfijo is null)
       and (eq_val_interfaz = @i_val_interfaz
             or @i_val_interfaz is null)
       and (eq_descripcion  = @i_descripcion
             or @i_descripcion is null)
       and t.codigo        = c.tabla
       and t.tabla         = 're_equivalencias'
       and c.valor         = eq_tabla
    order  by eq_tabla,
              eq_modulo,
              eq_mod_int,
              eq_val_cfijo,
              eq_val_interfaz

    alter table #equivalencias
      add Id int identity (1, 1);

    if @i_modo = 0
    begin
      set rowcount 20
      select
                '9984' = Id,                      --  'Id'                   
                '9985' = eq_modulo,               --  'Producto Id'          
                '9986' = c.valor,                 --  'Producto'             
                '9987' = eq_mod_int,              --  'Prod. Equiv. Id'      
                '9988' = c1.valor,                --  'Producto Equivalente' 
                '9989' = eq_cod_tabla,            --  'Codigo Tabla'         
                '9990' = eq_tabla,                --  'Tabla'                
                '9991' = eq_val_cfijo,            --  'Valor Cobis'          
                '9992' = eq_val_num_ini,          --  'Valor Inicial'        
                '9993' = eq_val_num_fin,          --  'Valor Final'          
                '9994' = eq_val_interfaz,         --  'Valor Interfaz'       
                '9995' = eq_descripcion           --  'Descripcion'          
      from   #equivalencias,
             cobis..cl_catalogo c,
             cobis..cl_tabla t,
             cobis..cl_catalogo c1,
             cobis..cl_tabla t1
      where  c.tabla   = t.codigo
         and t.tabla   = 'cl_producto'
         and c.codigo  = convert(varchar, eq_modulo)
         and c1.tabla  = t1.codigo
         and t1.tabla  = 'cl_producto'
         and c1.codigo = convert(varchar, eq_mod_int)
      order  by Id

      set rowcount 0
    end

    if @i_modo = 1
    begin
      set rowcount 20
      select
                '9984' = Id,                        --  'Id'                   
                '9985' = eq_modulo,                 --  'Producto Id'          
                '9986' = c.valor,                   --  'Producto'             
                '9987' = eq_mod_int,                --  'Prod. Equiv. Id'      
                '9988' = c1.valor,                  --  'Producto Equivalente' 
                '9989' = eq_cod_tabla,              --  'Codigo Tabla'         
                '9990' = eq_tabla,                  --  'Tabla'                
                '9991' = eq_val_cfijo,              --  'Valor Cobis'          
                '9992' = eq_val_num_ini,            --  'Valor Inicial'        
                '9993' = eq_val_num_fin,            --  'Valor Final'          
                '9994' = eq_val_interfaz,           --  'Valor Interfaz'       
                '9995' = eq_descripcion             --  'Descripcion'          
      from   #equivalencias,
             cobis..cl_catalogo c,
             cobis..cl_tabla t,
             cobis..cl_catalogo c1,
             cobis..cl_tabla t1
      where  c.tabla   = t.codigo
         and t.tabla   = 'cl_producto'
         and c.codigo  = convert(varchar, eq_modulo)
         and c1.tabla  = t1.codigo
         and t1.tabla  = 'cl_producto'
         and c1.codigo = convert(varchar, eq_mod_int)
         and Id        > @i_siguiente
      order  by Id

      set rowcount 0
    end
  end

  return 0

  VALIDAR_CATALOGO:
begin
  select
    @w_valor_cat = c1.valor
  from   cobis..cl_catalogo c,
         cobis..cl_catalogo c1,
         cobis..cl_tabla t,
         cobis..cl_tabla t1
  where  t.codigo  = c.tabla
     and t1.codigo = c1.tabla
     and t.tabla   = 're_equivalencias'
     and t1.tabla  = 're_eq_tabla'
     and c.codigo  = c1.codigo
     and c.valor   = ltrim(rtrim(@i_tabla))

  if exists (select
               1
             from   cobis..cl_catalogo c,
                    cobis..cl_tabla t
             where  t.codigo        = c.tabla
                and t.tabla         = ltrim(rtrim(@w_valor_cat))
                and upper(c.codigo) = @i_val_cfijo)
    select
      @cont = 1

  if (@cont = 0
      and @w_valor_cat = 'cl_departamento')
  begin
    --PARA CASO DE DEPARTAMENTO  - NO ES CATALOGO SINO TABLA - AGREGAR AQUI NUEVOS CASOS
    if exists (select
                 1
               from   cobis..cl_departamento
               where  @i_val_cfijo = convert(varchar, de_departamento))
      select
        @cont = 1
  end

  if (@cont = 1)
  begin
    if (@i_operacion = 'I')
      goto CATALOGOVALIDADOI
    if (@i_operacion = 'U')
      goto CATALOGOVALIDADOU
  end
  else
  begin
    --- VALOR COBIS NO SE ENCUENTRA EN EL CATALOGO
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251113
    return 1
  end
end

  return 0

go

