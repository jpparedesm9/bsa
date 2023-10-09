
/************************************************************************/
/*  Archivo:            cl_listexc.sp                                   */
/*  Stored procedure:   sp_lista_exclusion_dml                          */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Maria Jose Taco                                 */
/*  Fecha de escritura: 16-Dic-2019                                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
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
/*  Este stored procedure realiza el mantenimiento de Lista de Exclusion*/
/*  de Clientes para Santander                                          */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA         AUTOR     RAZON                                       */
/*  16-Dic-2019   MTA       Emision inicial                             */
/*  29-05-2023    DCU       Error 207570                                */
/************************************************************************/
use cobis
go

if exists (select 1 from   sysobjects where  name = 'sp_lista_exclusion_dml')
  drop proc sp_lista_exclusion_dml
go

create proc sp_lista_exclusion_dml
(
  @s_ssn          int,
  @s_user         login,  
  @t_debug        char(1)  = 'N',
  @t_file         varchar(10) = null,
  @t_trn          smallint,
  @t_show_version bit      = 0,
  @i_operacion    char(1),
  @i_ente         int      = null,
  @i_secuencial   int      = null,  
  @i_calif        char(1)  = null
)
as declare
   @w_sp_name            descripcion,
   @w_return             int,
   @w_num_error          int,
   @w_calif              char(1),
   @w_semaforo           varchar(32),
   @w_tipo_calif_eva_cli varchar(10),
   @w_nivel              char(1)
   

--Inicializar nombre del stored procedure
select @w_sp_name = 'sp_lista_exclusion_dml'


--VERSION
if @t_show_version = 1
begin
   print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
   return 0
end

-- Validar codigo de transacciones
if ((@t_trn <> 610 and @i_operacion = 'I') or
    (@t_trn <> 611 and @i_operacion = 'D') or
    (@t_trn <> 612 and @i_operacion = 'S') OR
    (@t_trn <> 612 and @i_operacion = 'Q'))
begin
   select @w_num_error = 151051 --Transaccion no permitida
   goto errores
end

if @i_operacion = 'I' 
BEGIN

   IF EXISTS(SELECT 1 FROM cl_clientes_calif WHERE cc_ente = @i_ente )
   begin 
      select @w_num_error = 201050 --ERROR AL INSERTAR EL CLIENTE EN LA LISTA DE EXCLUSION
      goto errores
   end
   
   select 
   @w_tipo_calif_eva_cli = ea_tipo_calif_eva_cli
   from cobis..cl_ente_aux 
   where ea_ente = @i_ente
      
   
   begin tran     
	  insert into cl_clientes_calif( cc_ente,  cc_calif)
      values                       ( @i_ente,  @i_calif)
     
      if @@error <> 0
      begin 
         select @w_num_error = 201050 --ERROR AL INSERTAR EL CLIENTE EN LA LISTA DE EXCLUSION
         goto errores
      end
      
	  insert into cl_lista_exclusion( le_ente,   le_accion,	  le_calif ,   le_fecha,   le_login )
      values                        ( @i_ente,   'I',         @i_calif,    getdate(),  @s_user)

      if @@error <> 0
      begin 
         select @w_num_error = 201050 --ERROR AL INSERTAR EL CLIENTE EN LA LISTA DE EXCLUSION
         goto errores
      end
      
  
      exec @w_return             = cobis..sp_riesgo_ind_externo
           @i_ente               = @i_ente,
	       @i_tipo_calif_eva_cli = @w_tipo_calif_eva_cli,
           @i_dias_vig_buro	     = 0,--Para colocar en null los valores y se actualice segun la pantalla
	       @i_evaluar_reglas     = 'S',
	       @i_excepcionable      = 'S',
           @o_nivel              = @w_nivel    output,
           @o_semaforo           = @w_semaforo output
      
      update cobis..cl_ente_aux
      set    ea_nivel_riesgo_cg = @w_nivel
      where  ea_ente = @i_ente
      
      update cobis..cl_ente
      set p_calif_cliente = @w_semaforo
      where  en_ente = @i_ente
      
      

   commit tran
   goto fin
end


if @i_operacion = 'D'
begin
    if not exists (select 1 from cl_clientes_calif where cc_ente = @i_ente)
    begin
        select @w_num_error =  201053 --ERROR AL BUSCAR DATOS DEL CLIENTE EN LA LISTA DE EXCLUSION
        goto errores
    end 
           
    begin tran 
       
       SELECT @w_calif = cc_calif
       FROM cl_clientes_calif
       WHERE cc_ente = @i_ente
        
       delete cl_clientes_calif
       where cc_ente = @i_ente
	 
	   if @@error <> 0
       begin
          select @w_num_error = 201052 --ERROR AL ELIMINAR DEL CLIENTE EN LA LISTA DE EXCLUSION
          goto errores
       end
              
       insert into cl_lista_exclusion( le_ente,   le_accion,   le_calif ,   le_fecha,   le_login )
       values                        ( @i_ente,   'E',         @w_calif,    getdate(),  @s_user)

       if @@error <> 0
       begin 
          select @w_num_error = 201052 --ERROR AL ELIMINAR DEL CLIENTE EN LA LISTA DE EXCLUSION
          goto errores
       end
    
    commit tran
goto fin
end

if (@i_ente IS NULL OR @i_ente=0) AND (@i_operacion = 'S' )
BEGIN
    --SELECT @i_operacion = 'S' 
    set rowcount 0
    select 'cliente'      = cc_ente,
           'nombreCliente'= en_nomlar,
           'rfc'          = en_rfc,
           'curp'         = en_ced_ruc,
           'calificacion' = cc_calif
      from cl_clientes_calif, cl_ente
     where cc_ente = en_ente
    order by cc_ente asc  
goto fin
end
ELSE
IF (@i_operacion = 'Q' AND @i_ente>0)
BEGIN
    set rowcount 0
    select 'cliente'      = cc_ente,
           'nombreCliente'= en_nomlar,
           'rfc'          = en_rfc,
           'curp'         = en_ced_ruc,
           'calificacion' = cc_calif
      from cl_clientes_calif, cl_ente
     where cc_ente = en_ente
       AND cc_ente = @i_ente
goto fin
end
--Control errores
errores:
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_num_error
   return @w_num_error
fin:
   return 0
go