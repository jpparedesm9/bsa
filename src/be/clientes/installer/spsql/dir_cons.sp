/************************************************************************/
/*  Archivo:            dir_cons.sp                                     */
/*  Stored procedure:   sp_direccion_cons                               */
/*  Base de datos:      cobis                                           */
/*  Producto: Clientes                                                  */
/*  Disenado por:  Mauricio Bayas/Sandra Ortiz                          */
/*  Fecha de escritura: 07-Nov-1992                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este programa procesa las transacciones de consultas de             */
/*  direcciones                                                         */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA         AUTOR           RAZON                                 */
/*  FECHA       AUTOR       RAZON                                       */
/*  07/Nov/92   M. Davila   Emision Inicial                             */
/*  19/Feb/13   D.Pulido    REQ - 349                                   */
/*  10/Abr/13   L.Moreno    REQ - 353 Alianzas Comerciales              */
/*  03/May/16   T. Baidal   Migracion a CEN                             */
/************************************************************************/
use cobis
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists (select * from sysobjects where name = 'sp_direccion_cons')
    drop proc sp_direccion_cons
go

create proc sp_direccion_cons (
    @s_ssn          int,
    @s_user         login       = null,
    @s_term         varchar(30) = null,
    @s_date         datetime          ,
    @s_srv          varchar(30) = null,
    @s_lsrv         varchar(30) = null,
    @s_ofi          smallint    = null,
    @s_rol          smallint    = null,
    @s_org_err      char(1)     = null,
    @s_error        int         = null,
    @s_sev          tinyint     = null,
    @s_msg          descripcion = null,
    @s_org          char(1)     = null,
    @t_debug        char(1)     = 'N',
    @t_file         varchar(10) = null,
    @t_from         varchar(32) = null,
    @t_trn          smallint    = null,
    @t_show_version bit         = 0,
    @i_operacion    char(1)     ,
    @i_opcion       char(1)     = null,
    @i_principal    char(1)     = 'N',     /*NVR*/
    @i_ente         int         = null,
    @i_direccion    tinyint     = null,
    @i_descripcion  varchar(254)= null,
    @i_tipo         catalogo    = null,
    @i_sector       catalogo    = null,
    @i_parroquia    int         = null,
    @i_barrio       char(40)    = null,
    @i_ciudad       int         = null,
    @i_oficina      smallint    = null,
    @i_verificado   char(1)     = 'N',
    @i_modo         char (1)    = 'N', --REQ 349 - DFP
    @i_cta_ah       cuenta      = null --REQ 353 - LCM
)
as
declare
    @w_transaccion      int,
    @w_sp_name          varchar(32),
    @w_codigo           int,
    @w_error            int,
    @w_return           int,
    @w_descripcion      varchar(254),
    @w_tipo             catalogo,
    @w_sector           catalogo,
    @w_zona_ant         catalogo,
    @w_zona             catalogo,
    @w_parroquia        smallint,
    @w_barrio           char(40),
    @w_ciudad           int,
    @w_oficina          smallint,
    @w_verificado       char(1),
    @w_vigencia         char(1),
    @w_principal        char(1),
    @w_tdn              varchar(30),
    @w_tpc              varchar(30),
    @w_tpc_ente         catalogo,
    @w_tipo_per         char(1),
    @w_tpw              varchar(10),
	@w_email 			varchar(254), 
	@w_count			int,
    @v_descripcion      varchar(254),
    @v_tipo             catalogo,
    @v_sector           catalogo,
    @v_zona             catalogo,
    @v_parroquia        smallint,
    @v_barrio           char(40),
    @v_ciudad           int,
    @v_oficina          smallint,
    @v_verificado       char(1),
    @v_vigencia         char(1),
    @v_principa         char(1),
    @o_ente             int,
    @o_ennombre         descripcion,
    @o_cedruc           numero,
    @o_direccion        tinyint,
    @o_descripcion      varchar(254),
    @o_ciudad           int,
    @o_cinombre         descripcion,
    @o_parroquia        smallint,
    @o_barrio           char(40),
    @o_pqnombre         descripcion,
    @o_tipo             catalogo,
    @o_tinombre         descripcion,
    @o_cod_prov         smallint,
    @o_provincia        descripcion,
    @o_sector_nombre    descripcion,
    @o_zona             catalogo,
    @o_zona_nombre      descripcion,
    @o_telefono         tinyint,
    @o_valor            varchar(12),
    @o_siguiente        int,
    @o_oficina          smallint,
    @o_ofinombre        descripcion,
    @o_verificado       char(1),
    @o_vigencia         char(1),
    @o_principal        char(1),
    @o_fecha_registro   datetime,
    @o_fecha_modificacion datetime,
    @o_funcionario      login,
    @o_fecha_ver        datetime,
    @o_tienetel         char(1),
    @o_rural_urb        char(1) ,
    @o_observacion      varchar(80),
    @o_barrio_descrip   varchar(80),
    @o_parTD            varchar(10),
    @o_ocupa            varchar(10),
    @o_dirempre         tinyint,
    @o_parOC            varchar(10),
    @o_parTR            varchar(10),
    @o_dircasa          tinyint,
    @o_parTC            varchar(10),
    @o_tipocli          varchar(10),
    @o_subtipo          char(1)

-- VER 12 JCO
select @w_sp_name = 'sp_direccion_cons'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
end

--selecciona el tipo direccion email
     select @w_tpw = pa_char
     from   cobis..cl_parametro   with (nolock)
     where  pa_producto = 'MIS'
     and    pa_nemonico = 'TDW'

     if @@rowcount = 0
     begin
        exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101077
            /* No existe parametro - direccion email */
        return 1
     end


/** Search **/

if @i_operacion = 'S'
begin
   if @t_trn = 1227
   begin
      if @i_modo = 'N'  --REQ 349 DFP
         begin
       /**select  'No.'            = di_direccion,
               'DIRECCION'      = substring(di_descripcion, 1, 60),
               'COD. CIUDAD'    = di_ciudad,
               'CIUDAD'         = substring(ci_descripcion,1,20),
               'BARRIO'         = case di_rural_urb
                                     when 'R' then di_barrio
                                     else (select pq_descripcion
                                           from cl_parroquia
                                           where pq_parroquia = x.di_parroquia
                                           and   pq_ciudad    = x.di_ciudad
                                           and   pq_estado    = 'V')
                                  end,
               'OFI. ATN-'      = di_zona,
               'DESC.OFI.ATN-'  = of_nombre,
               'DPTO.'          = di_provincia,
               'NOMBRE DEPTO.'  = pv_descripcion,
               'TIPO DIRECCION' = substring(c.valor, 1, 20),
               'OFICINA'        = di_oficina,
               'DESC.OFICINA'   = substring(of_nombre,1,30),
               'VERIF.'         = di_verificado,
               'VIGENTE'        = di_vigencia,
               'PRINCIPAL'      = di_principal,
               'TIENE_TEL'      = di_tienetel,
               'RURAL O URBANO' = di_rural_urb  ,
               'OBSERVACION'    = di_observacion
       from    cl_direccion x, cl_catalogo a, cl_tabla b,
               cl_oficina, cl_catalogo c, cl_tabla d, cl_ciudad,
               cl_provincia
       where  di_ente      = @i_ente
       and    di_ciudad    = ci_ciudad
       and    di_tipo      = c.codigo
       and    c.tabla      = d.codigo
       and    d.tabla      = 'cl_tdireccion'
       and    di_zona      * = a.codigo
       and    a.tabla      = * b.codigo
       and    b.tabla      = 'cl_oficina'
       and    of_oficina   = * di_zona
       and    di_provincia = pv_provincia
       and    di_tipo <> @w_tpw
       union
       select  'No.'            = di_direccion,
               'DIRECCION'      = substring(di_descripcion, 1, 25),
               'COD. CIUDAD'    = di_ciudad,
               'CIUDAD'         = '',
               'BARRIO'         = di_barrio,
               'OFI. ATN'       = di_zona,
               'DESC.OFI.ATN'   =  of_nombre,
               'DPTO.'          = di_provincia,
               'NOMBRE DEPTO.'  = '',
               'TIPO DIRECCION' = substring(c.valor, 1, 20),
               'OFICINA'        = di_oficina,
               'DESC.OFICINA'   = substring(of_nombre,1,30),
               'VERIF.'         = di_verificado,
               'VIGENTE'        = di_vigencia,
               'PRINCIPAL'      = di_principal,
               'TIENE_TEL'      = di_tienetel,
               'RURAL O URBANO' = di_rural_urb  ,
               'OBSERVACION'    = di_observacion
       from   cl_direccion,
              cl_oficina,
              cl_catalogo c,
              cl_tabla d
       where  di_ente     = @i_ente
       and    di_tipo     = c.codigo
       and    c.tabla     = d.codigo
       and    d.tabla     = 'cl_tdireccion'
       and    di_oficina * = of_oficina
       and    di_tipo     = @w_tpw
       ***/
       select
       'No.'                = di_direccion, --Address Id
       'DIRECCION'          = substring(di_descripcion, 1, 60), --Description
       'PAIS CODE'          = ci_pais,
       'PAIS ID'            = ci_pais,--CountryCode
       'PAIS'               = (SELECT pa_descripcion FROM cl_pais WHERE pa_pais = ci_pais),--Country
       'DPTO.'              = di_provincia, --Province Code
       'NOMBRE DEPTO.'      =  case di_tipo --Province
                                when @w_tpw then ''
                                else pv_descripcion
                            end,
       'DPTO.'              = di_provincia, --DepartmentId
       'NOMBRE DEPTO.'      =  case di_tipo --Department
                                when @w_tpw then ''
                                else pv_descripcion
                            end,       
       'COD. CIUDAD'        = di_ciudad, --City Code
       'CIUDAD'             = case di_tipo --City 
                                when @w_tpw then ''
                                else substring(ci_descripcion,1,20)
                            end,
       'BARRIO'             = case di_rural_urb --Neighbordhood
                                when 'R' then di_barrio
                                else (select pq_descripcion
                                    from cl_parroquia with (nolock)
                                    where pq_parroquia = x.di_parroquia
                                    and   pq_ciudad    = x.di_ciudad
                                    and   pq_estado    = 'V')
                            end,
       'OBSERVACION'        = di_observacion, --OtherSigns                         
       'TIPO DIRECCION'     = c.codigo,  --Type Code
       'TIPO '     = substring(c.valor, 1, 20), --type
       'OFICINA'            = isnull   (di_oficina, ''),--Office Code
       'DESC.OFICINA'       = substring(isnull(of_nombre,''),1,30),--Office
       'VERIF.'             = di_verificado,--Is Verified
       'PRINCIPAL'          = di_principal, --Is Main Address
       'MAIL'               = case c.codigo --IS Mail Address
                                when '001' then 'S'
                                else 'N'
                            end,
        'ISRENTED'          = null,
        'RENTAMOUNT'        = 0,
        'STREET'            = null,
        'HOUSE'             = null,
        'BUILDING'          = null,
        'COMERCIALADDRESS'  = null
       
       from    cl_ciudad      with (nolock),
               cl_provincia   with (nolock), cl_catalogo c with (nolock), cl_tabla d with (nolock),
               cl_direccion x with (nolock)
               LEFT OUTER JOIN cl_oficina  with (nolock)
                    ON di_zona = of_oficina

       where  di_ente      = @i_ente
       and    di_ciudad    = ci_ciudad
       and    di_provincia = pv_provincia
       and    di_tipo      = c.codigo
       and    c.tabla      = d.codigo
       and    d.tabla      = 'cl_tdireccion'
       order by di_ente, di_direccion
       end

       if @i_modo  = 'S'
          begin
             select
                    'No.'                = di_direccion, --Address Id
                    'DIRECCION'          = substring(di_descripcion, 1, 60), --Description
                    'PAIS CODE'          = ci_pais,
                    'PAIS ID'            = ci_pais,
                    'PAIS'               = (SELECT pa_descripcion FROM cl_pais WHERE pa_pais = ci_pais),
                    'DPTO.'              = di_provincia, --Province Code
                    'NOMBRE DEPTO.'      =  case di_tipo --Province
                                            when @w_tpw then ''
                                            else pv_descripcion
                                        end,
                    'DPTO.'              = di_provincia, --DepartmentId
                    'NOMBRE DEPTO.'      =  case di_tipo --Department
                                            when @w_tpw then ''
                                            else pv_descripcion
                                        end,       
                    'COD. CIUDAD'        = di_ciudad, --City Code
                    'CIUDAD'             = case di_tipo --City 
                                            when @w_tpw then ''
                                            else substring(ci_descripcion,1,20)
                                        end,
                    'BARRIO'             = case di_rural_urb --Neighbordhood
                                            when 'R' then di_barrio
                                            else (select pq_descripcion
                                                from cl_parroquia with (nolock)
                                                where pq_parroquia = x.di_parroquia
                                                and   pq_ciudad    = x.di_ciudad
                                                and   pq_estado    = 'V')
                                        end,
                    'OBSERVACION'        = di_observacion, --OtherSigns                         
                    'TIPO DIRECCION'     = c.codigo,  --Type Code
                    'TIPO DIRECCION'     = substring(c.valor, 1, 20), --type
                    'OFICINA'            = isnull   (di_oficina, ''),--Office Code
                    'DESC.OFICINA'       = substring(isnull(of_nombre,''),1,30),--Office
                    'VERIF.'             = di_verificado,--Is Verified
                    'PRINCIPAL'          = di_principal, --Is Main Address
                    'MAIL'               = case c.codigo --IS Mail Address
                                            when '001' then 'S'
                                            else 'N'
                                        end,
                    'ISRENTED'          = null,
                    'RENTAMOUNT'        = 0,
                    'STREET'            = null,
                    'HOUSE'             = null,
                    'BUILDING'          = null,
                    'COMERCIALADDRESS'  = null
             from    cl_ciudad      with (nolock),
                     cl_provincia   with (nolock), cl_catalogo c with (nolock), cl_tabla d with (nolock),
                     cl_direccion x with (nolock)
                     LEFT OUTER JOIN cl_oficina  with (nolock)
                     ON di_zona = of_oficina

             where  di_ente      = @i_ente
             and    di_ciudad    = ci_ciudad
             and    di_provincia = pv_provincia
             and    di_tipo      = c.codigo
             and    c.tabla      = d.codigo
             and    d.tabla      = 'cl_tdireccion'
             and    di_tipo = '001'  -- Req 349 - DFP
             order by di_ente, di_direccion
          end

       return 0
   end
   else
   begin
       exec sp_cerror
          @t_debug      = @t_debug,
          @t_file       = @t_file,
          @t_from       = @w_sp_name,
          @i_num        = 151051
          /*  'No corresponde codigo de transaccion' */
       return 1
   end
end

if @i_operacion = 'E'
begin


     select @i_ente = ah_cliente
       from cob_ahorros..ah_cuenta
      where ah_cta_banco = @i_cta_ah

     if @@rowcount = 0
     begin
           exec sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 251127
                   /* Cuenta no existe */
            return 1
      end


      if @i_opcion  = 'S'
       begin
            select  'No.'            = di_direccion,
                    'DIRECCION'      = substring(di_descripcion, 1, 100)
              from cl_direccion with (nolock)
              where  di_ente      = @i_ente
                and  di_tipo      = '001'  -- Req 349 - DFP
             order by di_direccion

           if @@rowcount = 0
           begin
               exec sp_cerror
                    @t_debug  = @t_debug,
                    @t_file   = @t_file,
                    @t_from   = @w_sp_name,
                    @i_num    = 101001,
                    @i_msg    = 'No existe direccion email'
               return 1
            end
      end



      if @i_opcion  = 'D'
      begin
           select  'DIRECCION'      = substring(di_descripcion, 1, 100)
             from cl_direccion with (nolock)
             where  di_ente         = @i_ente
                and di_direccion    = @i_direccion
                and  di_tipo        = '001'

           if @@rowcount = 0
            begin
               exec sp_cerror
                    @t_debug  = @t_debug,
                    @t_file   = @t_file,
                    @t_from   = @w_sp_name,
                    @i_num    = 101001,
                    @i_msg    = 'No existe direccion email'
               return 1
            end
      end

  return 0
end

/** Query **/
If @i_operacion = 'Q'
begin
   if @t_trn = 1228
   begin
      if exists (select 1 from cobis..cl_direccion with (nolock) where di_ente = @i_ente and di_direccion  = @i_direccion and di_tipo = '001')
      begin
         select  @o_direccion          = di_direccion,
                 @o_descripcion        = di_descripcion,
                 @o_tipo               = di_tipo,
                 @o_principal          = di_principal,
                 @o_tinombre           = substring(x.valor,1,30),
                 @o_ciudad             = di_ciudad,
                 @o_cinombre           = '',
                 @o_barrio             = di_barrio,
                 @o_cod_prov           = di_provincia,
                 @o_provincia          = '',
                 @o_zona               = di_zona,
                 @o_zona_nombre        = '',
                 @o_fecha_registro     = di_fecha_registro,
                 @o_fecha_modificacion = di_fecha_modificacion,
                 @o_verificado         = di_verificado,
                 @o_vigencia           = di_vigencia,
                 @o_funcionario        = di_funcionario,
                 @o_fecha_ver          = di_fecha_ver,
                 @o_tienetel           = di_tienetel,
                 @o_rural_urb          = di_rural_urb  ,
                 @o_observacion        = di_observacion
       from    cl_catalogo x with (nolock),  cl_ente      with (nolock),
               cl_tabla y with (nolock),     cl_direccion with (nolock)
               LEFT OUTER JOIN cl_oficina   with (nolock)
                    ON di_oficina  = of_oficina
       where   en_ente      = @i_ente
       and     en_ente      = di_ente
       and     di_direccion = @i_direccion
       and     y.tabla      = 'cl_tdireccion'
       and     x.tabla      = y.codigo
       and     di_tipo      = x.codigo
       and     di_tipo      = @w_tpw

         if @@rowcount = 0
         begin
            exec sp_cerror
              @t_debug  = @t_debug,
              @t_file   = @t_file,
              @t_from   = @w_sp_name,
              @i_num    = 101001
             /* 'No existe dato solicitado --'*/
            return 1
         end
      end
      else
      begin
         select  @o_direccion           = di_direccion,
                 @o_descripcion         = di_descripcion,
                 @o_tipo                = di_tipo,
                 @o_principal           = di_principal,
                 @o_tinombre            = substring(x.valor,1,30),
                 @o_ciudad              = ci_ciudad,
                 @o_cinombre            = substring(ci_descripcion,1,30),
                 @o_barrio              = di_barrio,
                 @o_cod_prov            = di_provincia,
                 @o_provincia           = pv_descripcion,
                 @o_zona                = di_zona,
                 @o_zona_nombre         = of_nombre,
                 @o_fecha_registro      = di_fecha_registro,
                 @o_fecha_modificacion  = di_fecha_modificacion,
                 @o_verificado          = di_verificado,
                 @o_vigencia            = di_vigencia,
                 @o_funcionario         = di_funcionario,
                 @o_fecha_ver           = di_fecha_ver,
                 @o_tienetel            = di_tienetel,
                 @o_rural_urb           = di_rural_urb,
                 @o_observacion         = di_observacion ,
                 @o_parroquia           = di_parroquia
          from   cl_catalogo x  with (nolock),  cl_ente       with (nolock),
                 cl_ciudad      with (nolock),  cl_tabla y    with (nolock),
                 cl_provincia e with (nolock),  cl_direccion  with (nolock)
                 LEFT OUTER JOIN cl_oficina with (nolock)
                      ON di_oficina   = of_oficina
         where   en_ente      = @i_ente
         and     en_ente      = di_ente
         and     di_direccion = @i_direccion
         and     y.tabla      = 'cl_tdireccion'
         and     x.tabla      = y.codigo
         and     di_tipo      = x.codigo
         and     di_ciudad    = ci_ciudad
         and     di_provincia = pv_provincia
         and     di_tipo      <> @w_tpw

         if @@rowcount = 0
         begin
             exec sp_cerror
               @t_debug  = @t_debug,
               @t_file   = @t_file,
               @t_from   = @w_sp_name,
               @i_num    = 101001,
               @i_msg    = 'No existe detalle de direccion'
              /* 'No existe dato solicitado -'*/
             return 1
         end

         if @o_zona is not null and @o_zona <> 0
         begin
            select  @o_zona_nombre = of_nombre
            from    cl_oficina with (nolock)
            where   of_oficina = @o_zona

            if @@rowcount = 0
            begin
               exec sp_cerror
                 @t_debug  = @t_debug,
                 @t_file   = @t_file,
                 @t_from   = @w_sp_name,
                 @i_num    = 101001,
                 @i_msg    = 'Codigo de oficina no existe'
                /* 'No existe dato solicitado oficina'*/
               return 1
            end
         end
         else
            select @o_zona_nombre = ''


         if @o_rural_urb   = 'U'  --urbano
         begin
            select @o_barrio_descrip = c.valor
            from   cl_catalogo c with (nolock), cl_tabla t with (nolock)
            where  c.tabla  = t.codigo
            and    t.tabla  = 'cl_parroquia'
            and    c.codigo = convert(varchar(10),@o_parroquia)
            --and    c.estado = 'V' permitir que despliegue catalogos no vigentes para que se pueda actualizar el valor.

            if @@rowcount = 0
            begin
               exec sp_cerror
                    @t_debug  = @t_debug,
                    @t_file   = @t_file,
                    @t_from   = @w_sp_name,
                    @i_num    = 101001,
                    @i_msg    = 'No existe barrio de la direccion'
                    /* 'No existe dato solicitado oficina'*/
               return 1
            end
         end
         else
            select @o_barrio_descrip = @o_barrio
      end

      select  @o_direccion,
              @o_descripcion,
              @o_ciudad,
              @o_cinombre,
              @o_barrio,
              @o_tipo,
              @o_tinombre,
              @o_cod_prov,
              @o_provincia,
              @o_zona,
              @o_zona_nombre,
              @o_verificado,
              @o_vigencia,
              convert(varchar(10),@o_fecha_registro,101),
              convert(varchar(10),@o_fecha_modificacion,101),
              @o_funcionario,
              convert(varchar(10),@o_fecha_ver,101),
              @o_principal,
              @o_tienetel ,
              @o_rural_urb,
              @o_observacion ,
              @o_barrio_descrip,
              @o_parroquia
   end
   else
   if @t_trn = 1345 /*Consulta de Telefonos de CLiente NVR */
   begin

      select  'SEC.'          = te_secuencial,
              'NUMERO'        = rtrim(ltrim(te_valor)),
              'COD.'          = te_tipo_telefono,
              'TIPO TELEFONO' = (select substring(b.valor, 1, 10) from cl_tabla a, cl_catalogo b
                                        where a.tabla = 'cl_ttelefono'
                                        and   a.codigo = b.tabla
                                        and   b.codigo = T.te_tipo_telefono),
              'INDICATIVO'    = te_prefijo,
              'TIPO OPERADOR' = te_tipo_operador,
              'DESC. TIPO OPERADOR' = (select substring(b.valor, 1, 10) from cl_tabla a, cl_catalogo b
                                        where a.tabla = 'cl_tipo_operador'
                                        and   a.codigo = b.tabla
                                        and   b.codigo = T.te_tipo_operador)
    from   cl_telefono T with(nolock)
    where  te_ente    = @i_ente
    and  te_direccion = @i_direccion
    order  by te_ente, te_direccion, te_secuencial

    return 0
   end
   else
   begin
       exec sp_cerror
          @t_debug      = @t_debug,
          @t_file       = @t_file,
          @t_from       = @w_sp_name,
          @i_num        = 151051
          /*  'No corresponde codigo de transaccion' */
       return 1
   end
end

/* ** HELP **/
if @i_operacion = 'H'
begin
   if @t_trn = 1229
   begin
      if @i_tipo = 'A'
          select 'SEC.'        = di_direccion,
                 'DESCRIPCION' = substring(di_descripcion,1,40)
          from   cl_direccion with (nolock)
          where  di_ente = @i_ente
      else
      begin
          select di_descripcion
          from   cl_direccion with (nolock)
          where  di_ente = @i_ente
          and    di_direccion = @i_direccion

          if @@rowcount = 0
          begin
          exec sp_cerror
             @t_debug  = @t_debug,
             @t_file   = @t_file,
             @t_from   = @w_sp_name,
             @i_num    = 101001
             /* 'No existe dato solicitado'*/
             return 1
          end
      end

      if @i_tipo = 'B'
         if not exists ( select di_direccion
                         from  cl_direccion with (nolock)
                         where di_ente      = @i_ente
                         and   di_principal = 'S')
         begin
            exec sp_cerror
               @t_debug  = @t_debug,
               @t_file   = @t_file,
               @t_from   = @w_sp_name,
               @i_num    = 101188
               /* 'Debe existir una direccion principal'*/
            return 1
         end

      return 0

   end
   else
   begin
       exec sp_cerror
          @t_debug      = @t_debug,
          @t_file       = @t_file,
          @t_from       = @w_sp_name,
          @i_num        = 151051
          /*  'No corresponde codigo de transaccion' */
       return 1
   end
end

/* ** Validacion **/
if @i_operacion = 'V'
begin
  if @t_trn = 1345
  begin
     select @w_tdn = pa_char
     from   cobis..cl_parametro with (nolock)
     where  pa_producto = 'MIS'
     and    pa_nemonico = 'TDN'

     if @@rowcount = 0
     begin
        exec sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 101187
             /* No existe codigo para tipo direccion de negocio */
        return 1
     end

     select @w_tpc = pa_char
     from   cobis..cl_parametro with (nolock)
     where  pa_producto = 'MIS'
     and    pa_nemonico = 'TPC'

     if @@rowcount = 0
     begin
        exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101187
            /* No existe codigo para tipo de persona cliente */
        return 1
     end

     select @w_tpc_ente = p_tipo_persona,
            @w_tipo_per = en_subtipo
     from   cobis..cl_ente with (nolock)
     where  en_ente = @i_ente

     if @@rowcount = 0
     begin
        exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103000
            /* Cliente no existe */
        return 1
     end

     if @w_tipo_per = 'C'
        return 0


   if (@w_tpc_ente = @w_tpc)
   begin
       select @i_ente =  di_ente
       from cobis..cl_direccion with (nolock)
       where di_ente = @i_ente
       and   di_tipo = @w_tdn

       if @@rowcount = 0
       begin
          exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101225
              /* Cliente debe tener direccion de negocio */
          return 1
       end
    end
    return 0
  end
end


if @i_operacion = 'Z'
    begin
	if @i_tipo = 'G'
	begin
			select @w_email = di_descripcion, @w_count = count (*) from cobis..cl_direccion where di_ente in  
            (select  cg_ente from cobis..cl_cliente_grupo where cg_grupo = @i_ente and cg_estado = 'V') and  di_tipo = 'CE' group by di_descripcion having count(*) > 1

			select di_ente,di_descripcion into #correos from cobis..cl_direccion where di_descripcion is not null
			
			if exists(select di_descripcion from #correos where di_descripcion = @w_email)
			begin
				exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file  = @t_file,
					@t_from  = @w_sp_name,
				 @i_num   = 70074
            /* Correo electronico ya existe */
            return 0
			end

			if exists(select 1 from cobis..cl_direccion where di_ente in
			(select  cg_ente from cobis..cl_cliente_grupo where cg_grupo = @i_ente and cg_estado = 'V')
			and di_tipo <> 'CE' and di_referencia is null ) -- por caso #139268
			begin
				exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file  = @t_file,
					@t_from  = @w_sp_name,
				 @i_num   = 70075
            /* El campo de referencia es obligatorio */
            return 0	
			end

			drop table #correos
			
			
    end
	if @i_tipo = 'I'
	begin
			select @w_email = di_descripcion from cobis..cl_direccion where di_ente = @i_ente and di_tipo = 'CE'

			select di_ente,di_descripcion into #correosI from cobis..cl_direccion where di_descripcion is not null and di_ente <> @i_ente
			
			if exists(select di_descripcion from #correosI where di_descripcion = @w_email)
			begin
				exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file  = @t_file,
					@t_from  = @w_sp_name,
				 @i_num   = 70074
            /* Correo electronico ya existe */
            return 0	
			end
			
			if exists(select 1 from cobis..cl_direccion where di_ente = @i_ente and di_tipo ='RE' and di_referencia is null )
			begin
				exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file  = @t_file,
					@t_from  = @w_sp_name,
				 @i_num   = 70075
            /* El campo de referencia es obligatorio */
            return 0	
			end

			drop table #correosI
	end

	end



if @i_operacion = 'X'
begin
   if @t_trn = 1227
   begin
      select @o_parTD = isnull(pa_char,'N')
      from cobis..cl_parametro with (nolock)
     where pa_producto = 'MIS'
       and pa_nemonico = 'TDEM'

     if @@rowcount <> 1
     begin
       exec cobis..sp_cerror
         @t_debug     = @t_debug,
         @t_file      = @t_file,
         @t_from      = @w_sp_name,
         @i_num       = 101001,
         @i_msg       = 'NO EXISTE TIPO DIRECCION EMPRESA'
       return  101001
      end

      select @o_parOC = isnull(pa_char,'N')  -- PAR EMPLEADO
      from cobis..cl_parametro  with (nolock)
     where pa_producto = 'MIS'
       and pa_nemonico = 'OCE'

     if @@rowcount <> 1
     begin
       exec cobis..sp_cerror
         @t_debug     = @t_debug,
         @t_file      = @t_file,
         @t_from      = @w_sp_name,
         @i_num       = 101002,
         @i_msg       = 'NO EXISTE PARAMETRO DE MONTO '
       return  101002
      end

      select @o_ocupa  = 'S'  --OCUPACION DEL CLIENTE
       from  cobis..cl_ente with (nolock)
       where en_ente = @i_ente
         and en_concordato = @o_parOC

/*      if @@rowcount = 0
      begin
         exec sp_cerror
              @t_debug    = @t_debug,
              @t_file     = @t_file,
              @t_from     = @w_sp_name,
              @i_num      = 101003
              /* 'No existe dato solicitado'*/
         return 101003
      end
*/
      select @o_dirempre = count(0)
      from cobis..cl_direccion with (nolock)
     where di_ente  = @i_ente
       and di_tipo  = @o_parTD


      select @o_parTR = isnull(pa_char,'N')
      from cobis..cl_parametro  with (nolock)
     where pa_producto = 'MIS'
       and pa_nemonico = 'TDR'

     if @@rowcount <> 1
     begin
       exec cobis..sp_cerror
         @t_debug     = @t_debug,
         @t_file      = @t_file,
         @t_from      = @w_sp_name,
         @i_num       = 101001,
         @i_msg       = 'NO EXISTE TIPO DIRECCION RESIDENCIA'
       return  101001
      end

      select @o_dircasa = isnull(count(0),0)
      from cobis..cl_direccion with (nolock)
     where di_ente  = @i_ente
       and di_tipo  = @o_parTR

      select @o_parTC = pa_char
      from cobis..cl_parametro  with (nolock)
     where pa_producto = 'MIS'
       and pa_nemonico = 'TCPAS'

      select @o_tipocli  = p_tipo_persona,
             @o_subtipo  = en_subtipo
       from  cobis..cl_ente with (nolock)
       where en_ente = @i_ente

      select @o_dircasa = isnull(count(0),0)
        from cobis..cl_direccion with (nolock)
       where di_ente  = @i_ente
         and di_tipo  = @o_parTR


      select 'parametro '   = @o_parTD,
             'ocuapacion'   = @o_ocupa,
             'dirempre'     = @o_dirempre,
             'tipocli'      = @o_tipocli,
             'parametropas' = @o_parTC,
             'dircasa'      = @o_dircasa,
             'tipoper'      = @o_subtipo

      return 0
   end
   else
   begin
       exec sp_cerror
          @t_debug  = @t_debug,
          @t_file   = @t_file,
          @t_from   = @w_sp_name,
          @i_num    = 151051
          /*  'No corresponde codigo de transaccion' */
       return 1
   end
end


go
