/* ********************************************************************* */
/*   Archivo:              bsa_crear_telefono.sp                         */
/*   Stored procedure:     sp_bsa_crear_telefono                         */
/*   Base de datos:        cobis                                         */
/*   Producto:             CLIENTES                                      */
/*   Disenado por:         Sonia Rojas                                   */
/*   Fecha de escritura:   15/Julio/2021                                 */
/* ********************************************************************* */
/*            IMPORTANTE                                                 */
/* ********************************************************************* */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "MACOSA", representantes exclusivos para el Ecuador de la           */
/*   "NCR CORPORATION".                                                  */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/* ********************************************************************* */
/*            PROPOSITO                                                  */
/* ********************************************************************* */
/*   Este stored procedure inserta personas con datos incompletos        */
/*            MODIFICACIONES                                             */
/*   FECHA        AUTOR     RAZON      NEMONICO                          */
/* ********************************************************************* */
/*   15/Jul/2021  WTO       Emisión Inicial-Creación Masiva de Prospectos*/
/* ********************************************************************* */

use cobis
go

IF OBJECT_ID ('dbo.sp_bsa_crear_telefono') IS NOT NULL
	DROP PROCEDURE dbo.sp_bsa_crear_telefono
GO

create procedure sp_bsa_crear_telefono (
   @s_ssn              int         = null,
   @s_user             login       = null,
   @s_term             varchar(32) = null,
   @s_sesn             int         = null,
   @s_culture          varchar(10) = null,
   @s_date             datetime    = null,
   @s_srv              varchar(30) = null,
   @s_lsrv             varchar(30) = null,
   @s_ofi              smallint    = null,
   @s_rol              smallint    = null,
   @s_org_err          char(1)     = null,
   @s_error            int         = null,
   @s_sev              tinyint     = null,
   @s_msg              descripcion = null,
   @s_org              char(1)     = null,
   @p_alterno          tinyint     = null,
   @t_debug            char(1)     = 'N',
   @t_file             varchar(10) = null,
   @t_from             varchar(32) = null,
   @t_trn              smallint    = null,
   @i_operacion        char(1),
   @i_ente             int         = null,  -- Codigo del ente al cual se le asocia un telefono
   @i_direccion        tinyint     = null,  -- Codigo de la direccion a la cual se asocia un telefono
   @i_secuencial       tinyint     = null,  -- Numero que indica la cantidad de telefonos que tiene el cliente
   @i_valor            varchar(16) = null,  -- Numero de telefono
   @i_tipo_telefono    char(2)     = null,  -- Tipo de telefono
   @i_te_telf_cobro    char(1)     = 'N',   -- Especifica si es telefono para gestion de cobro //DVE
   @i_tborrado         char(1)     = 'D',   -- 'D' - Unicamente se va a eliminar el telefono seleccionado
   @i_ejecutar         char(1)     = 'N',    --MALDAZ 06/25/2012 HSBC CLI-0565  
   
   @t_show_version bit  = 0
   ,      -- Mostrar la versión del programa   
   @i_verificado       char(1)     = null,
   @i_formato_fecha    int         = null,
   @i_cod_area         varchar(10) = null,  -- req27122
                  -- 'T' - Se van a eliminar TODAS los telefonos asociados a la dir.
   @i_tipo_telefono_gob char(2)    = null
)
as
declare
@w_transaccion      int,
@w_sp_name          varchar(32),
@w_aux              int,
@w_valor            varchar(16),
@w_tipo_telefono    char(2),
@w_secuencial       varchar(3),
@w_di_telefono      tinyint,
@v_valor            varchar(16),
@v_tipo_telefono    char(2),
@o_siguiente        int,
@w_te_telf_cobro    varchar(1), --DVE
@v_te_telf_cobro    varchar(1) ,--DVE
@w_doble_aut        char(1),    --Miguel Aldaz  06/22/2012 Doble autorización CLI-0565 HSBC
@w_autorizacion     int,        --Miguel Aldaz  06/22/2012 Doble autorización CLI-0565 HSBC
@w_estado_campo     char(1),    --Miguel Aldaz  06/26/2012 Doble autorización CLI-0565 HSBC
@w_return           int,
@w_verificado       char(1),
@w_cod_area         varchar(10), -- req-27122
@v_cod_area         char(10),    -- req-27122
@v_verificado       char(1),
@w_act_duplicado_tel char(1) = 'N'
   
if @t_show_version = 1
begin
  print 'Stored Procedure=sp_bsa_crear_telefono Version=4.0.6172.5341 TFS-ChangeSet=C147439 TFS-GetDate=2016-54-24'
  return 0
end

select @w_sp_name = 'sp_bsa_crear_telefono'
select @w_act_duplicado_tel = pa_char from cobis..cl_parametro where pa_producto = 'CLI' and pa_nemonico in ('ACCEDU')

/** Insert **/
if @i_operacion = 'I'
begin
   if @t_trn = 111 begin
      -- Verificacion de claves foraneas 

      if not exists (
                     select di_ente
                     from   cl_direccion
                     where  di_ente      = @i_ente
                     and    di_direccion = @i_direccion )
      begin
         return 101001
      end
      
      if not exists ( select codigo
                      from   cl_catalogo
                      where  codigo = @i_tipo_telefono
                      and    tabla  = ( select codigo
                                        from   cl_tabla
                                        where  tabla = 'cl_ttelefono'))
      begin
         return 101025
      end
      
      update cl_direccion
      set    di_telefono  = isnull(di_telefono,0) + 1
      where  di_ente     = @i_ente
      and    di_direccion = @i_direccion
      
      if @@error != 0
      begin
         exec sp_cerror
              @t_debug        = @t_debug,
              @t_file         = @t_file,
              @t_from         = @w_sp_name,
              @i_num          = 105035
              --   'Error en incremento de telefono'
         return 105035
      end
         
      select @o_siguiente = di_telefono
      from   cl_direccion
      where  di_ente      = @i_ente
      and    di_direccion = @i_direccion

      
	  if(@i_tipo_telefono = 'C')
      begin
         if(@w_act_duplicado_tel = 'N') begin
            if exists ( select te_valor
                        from   cl_telefono
                        where  te_valor             = @i_valor
						and    te_tipo_telefono = 'C')
            begin
                 --'El teléfono ya esta asociado a una dirección.'
                 return  107082      
            end
         end
      end
            
       insert into cl_telefono 
       (
               te_ente,              te_direccion,     te_secuencial,
               te_valor,             te_tipo_telefono, te_telf_cobro,--DVE
               te_funcionario,       te_verificado,    te_fecha_registro, te_area
       )  --req-27122                
       values                        
       (       @i_ente,              @i_direccion,     @o_siguiente,
               @i_valor,             @i_tipo_telefono, @i_te_telf_cobro,--DVE
               @s_user,              'N',              @s_date,           @i_cod_area
       )
       
       if @@error <> 0
       begin
      
             return 103038
       end

      return 0
   end
   else
   begin
      return 151051
   end
end


GO

