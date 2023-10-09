/************************************************************************/
/*	Archivo:		oficial.sp				                            */
/*	Stored procedure:	sp_oficiales				                    */
/*	Base de datos:		cob_cartera				                        */
/*	Producto: 		Cartera					                            */
/*	Disenado por:  		Zoila Bedon				                        */
/*	Fecha de escritura:	Ene 1998				                        */
/************************************************************************/
/*				IMPORTANTE				                                */
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	HMACOSA".							                                */
/*	Su uso no autorizado queda expresamente prohibido asi como	        */
/*	cualquier alteracion o agregado hecho por alguno de sus		        */
/*	usuarios sin el debido consentimiento por escrito de la 	        */
/*	Presidencia Ejecutiva de MACOSA o su representante.		            */
/************************************************************************/  
/*				PROPOSITO				                                */
/*      Obtener los oficiales de las tablas de COBIS                    */
/*  Abr-09-2008  MRoa      Modificacion opcion 'A' oficiales por oficina*/
/*  Nov-09-2017  P. Ortiz  Se agrega opcion 'C' para filtrado de combos */
/*  Nov-11-2017  P. Ortiz  Modifacion opción a para filtrado servidor   */
/************************************************************************/


use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_oficiales')
   drop proc sp_oficiales
go

create proc sp_oficiales (
   @i_tipo        char(1),
   @i_oficial     int     	  = 0,
   @i_oficina     int     	  = null,
   @i_truta       tinyint 	  = null,
   @i_estacion    int     	  = null,
   @i_filtro      varchar(50) = null
   
)
as declare 
   @w_sp_name	  descripcion,
   @w_fecha_hoy   datetime,
   @w_return	  int,
   @w_error       int,
   @w_rowcount    int,
   @w_msg         varchar(130),
   @w_opi         char(1),
   @w_oficina     smallint,
   @w_retorno_of  varchar(64)
   
    create table #estacion_tmp(
   es_estacion  smallint null)
   
   create table #estacion_tmp1(
   es_estacion  smallint null)

if @i_tipo = 'K' begin
   ---PARA LAS REGIONALES DEL BAC
   select @i_oficial =  isnull(@i_oficial, 0)

   set rowcount 20

   select  
   'REGIONAL' = codigo_sib,
   'NOMBRE'   = descripcion_sib
    from cob_credito..cr_corresp_sib
    where tabla = 'T21'
    and convert(int,codigo_sib)   > @i_oficial
   order by codigo_sib
   set transaction isolation level read uncommitted

   set rowcount 0

   return 0

end

if @i_tipo = 'L' begin
   ---PARA LAS REGIONALES DEL BAC
   select @i_oficial =  isnull(@i_oficial, 0)

   select  
    descripcion_sib
    from cob_credito..cr_corresp_sib
    where tabla = 'T21'
    and convert(int,codigo_sib) = @i_oficial
    if @@rowcount = 0
    begin
       PRINT 'Atncion !!! No existe la  regional  digitada -- > ' + cast(@i_oficial as varchar)
    end
   return 0

end

if @i_tipo = 'A' begin

   select @i_oficial =  isnull(@i_oficial, 0)

   --set rowcount 0

   select  
   'OFICIAL' = oc_oficial,
   'NOMBRE'  = substring(fu_nombre,1,30)
   from  cobis..cc_oficial,cobis..cl_funcionario,cobis..cl_catalogo
   where oc_oficial       > @i_oficial
   and   oc_funcionario   = fu_funcionario 
   and  (fu_oficina       = @i_oficina or @i_oficina is null)
   and   codigo           = oc_tipo_oficial
   and   tabla = (select codigo from cobis..cl_tabla
                 where tabla = 'cc_tipo_oficial')
   order by fu_nombre,oc_oficial
   set transaction isolation level read uncommitted

   set rowcount 0

   return 0

end


if @i_tipo = 'C' begin

   select @i_oficial =  isnull(@i_oficial, 0)
   
   
   if(@i_oficial = 0 )
   begin
       
      set rowcount 20

	   select  
	   'OFICIAL' = oc_oficial,
	   'NOMBRE'  = substring(fu_nombre,1,64)
	   from  cobis..cc_oficial,cobis..cl_funcionario,cobis..cl_catalogo
	   where oc_funcionario   = fu_funcionario 
	   and   codigo           = oc_tipo_oficial
	   and   tabla = (select codigo from cobis..cl_tabla
	                 where tabla = 'cc_tipo_oficial')
	   and UPPER(fu_nombre) like UPPER(@i_filtro+'%')
	   order by fu_nombre, oc_oficial
	   set transaction isolation level read uncommitted
	
	   set rowcount 0
	   
	   return 0

   end
   else
   begin
       
       select @i_filtro = substring(fu_nombre,1,64) 
       from cobis..cc_oficial, cobis..cl_funcionario
       where oc_oficial = @i_oficial
       and   oc_funcionario   = fu_funcionario
       
	   set rowcount 20

	   select  
	   'OFICIAL' = oc_oficial,
	   'NOMBRE'  = substring(fu_nombre,1,64)
	   from  cobis..cc_oficial,cobis..cl_funcionario,cobis..cl_catalogo
	   where oc_funcionario   = fu_funcionario 
	   and   codigo           = oc_tipo_oficial
	   and   tabla = (select codigo from cobis..cl_tabla
	                 where tabla = 'cc_tipo_oficial')
	   and UPPER(fu_nombre) like UPPER(@i_filtro+'%')
	   order by fu_nombre, oc_oficial
	   set transaction isolation level read uncommitted
	
	   set rowcount 0
	   
	   return 0
	   
   end
   

end

if @i_tipo = 'H' begin 


   select @i_oficial =  isnull(@i_oficial, 0)
   set transaction isolation level read uncommitted
   
   
   set rowcount 20
   select  
   'OFICIAL' = oc_oficial,
   'NOMBRE'  = fu_nombre
   --'NIVEL'   = valor
   from  cobis..cc_oficial,cobis..cl_funcionario,cobis..cl_catalogo
   where oc_oficial       > @i_oficial
   and   oc_funcionario   = fu_funcionario 
   and  (fu_oficina       = @i_oficina or @i_oficina is null)
   and   codigo           = oc_tipo_oficial
   and   tabla = (select codigo from cobis..cl_tabla
                 where tabla = 'cc_tipo_oficial')
   order by oc_oficial
   set rowcount 0

   set transaction isolation level read committed
   

   
   return 0

end



/* Tipo Value dado el codigo del oficial retornar el nombre */

if @i_tipo = 'V' begin

   select  'NOMBRE'         = substring(fu_nombre,1,30)
   from  cobis..cc_oficial,cobis..cl_funcionario
   where  oc_oficial      = @i_oficial
   and  (fu_oficina       = @i_oficina or @i_oficina is null)
   and  oc_funcionario    = fu_funcionario
   select @w_rowcount = @@rowcount
   set transaction isolation level read uncommitted

   if @w_rowcount = 0 begin
      select @w_error = 201121
      goto ERROR
   end

   return 0
end

if @i_tipo = 'E' begin -- Codigo de la estacion a la que le llegara un tramite en la primera instancia de aprobacion
         
    /*DETERMINA SI ES UNA OFICINA OPI*/  
    select @w_opi = to_opi
    from cob_credito..cr_tipo_oficina
    where to_oficina = @i_oficina
        
    if @w_opi = 'N'
    begin
        /*INGRESA ESTACION EMA*/
        insert into #estacion_tmp
		select es_estacion 
        from cob_credito..cr_estacion with (nolock)
        where es_oficina = @i_oficina
          and es_ema     = 'S'
          
        /*INGRESA DIRECTOR DE OFICINA*/      
        insert into #estacion_tmp
        select es_estacion 
        from cob_credito..cr_estacion
        where es_estacion_sup is not null
          and es_oficina  = @i_oficina
          and es_estacion not in (select es_estacion from #estacion_tmp)
    end
    else
	begin
	    /*INGRESA ESTACION EMA*/
	    insert into #estacion_tmp
		select es_estacion 
        from cob_credito..cr_estacion with (nolock)
        where es_oficina = @i_oficina
          and es_ema     = 'S'
    end

   --select es_estacion into #estacion_tmp
   --from cob_credito..cr_estacion
   --where es_estacion not in (select es_estacion_sup from cob_credito..cr_estacion)
   
   --insert into #estacion_tmp
   --select es_estacion_sup
   --from cob_credito..cr_estacion
   --where es_estacion in (select es_estacion from #estacion_tmp)
   --  and es_estacion_sup is not null
   
   select @i_estacion =  isnull(@i_estacion, 0)
   
   set rowcount 20
   
   select distinct  Estacion = A.es_estacion, Nombre_Estacion = ltrim(rtrim(fu_nombre))
   from cob_credito..cr_estacion B,
        cob_credito..cr_etapa_estacion,
        cob_credito..cr_etapa,
        cob_credito..cr_pasos,
        cobis..cl_funcionario,
        #estacion_tmp A
   where B.es_estacion   = ee_estacion
     and ee_etapa      = et_etapa
     and ee_estado     = 'A'
     and et_tipo       = 'A'
     and et_etapa      = pa_etapa
     and pa_truta      = @i_truta
     and A.es_estacion = B.es_estacion
     and A.es_estacion > 0--@i_estacion
     and B.es_usuario  = fu_login
     and es_oficina    = @i_oficina
     and fu_estado     = 'V'
   order by A.es_estacion
   
   set rowcount 0
   return 0
end

if @i_tipo = 'M' begin -- Login de Estacion del Ejecutivo Master o Director de Oficina

   select distinct
       @w_oficina  = es_oficina 
   from cob_credito..cr_estacion with (nolock),
         cobis..cl_funcionario with (nolock)
   where es_usuario   = fu_login
     and fu_estado    = 'V'
     and es_estacion  = @i_estacion
         
    /*DETERMINA SI ES UNA OFICINA OPI*/  
    select @w_opi = to_opi
    from cob_credito..cr_tipo_oficina
    where to_oficina = @w_oficina
      
    if @w_opi = 'N'
    begin
        /*INGRESA ESTACION EMA*/
        insert into #estacion_tmp1
		select es_estacion 
        from cob_credito..cr_estacion with (nolock)
        where es_oficina = @w_oficina
          and es_ema     = 'S'
          
        /*INGRESA DIRECTOR DE OFICINA*/      
        insert into #estacion_tmp1
        select es_estacion 
        from cob_credito..cr_estacion
        where es_estacion_sup is not null
          and es_oficina  = @w_oficina
          and es_estacion not in (select es_estacion from #estacion_tmp1)
    end
    else
	begin
	    /*INGRESA ESTACION EMA*/
	    insert into #estacion_tmp1
		select es_estacion 
        from cob_credito..cr_estacion with (nolock)
        where es_oficina = @w_oficina
          and es_ema     = 'S'
    end
   
   select @w_retorno_of = 'ERROR'
        
   select @w_retorno_of = ltrim(rtrim(fu_nombre))
   from cob_credito..cr_estacion B,
        cob_credito..cr_etapa_estacion,
        cob_credito..cr_etapa,
        cob_credito..cr_pasos,
        cobis..cl_funcionario,
        #estacion_tmp1 A
   where B.es_estacion = ee_estacion
     and ee_etapa      = et_etapa
     and ee_estado     = 'A'
     and et_tipo       = 'A'
     and et_etapa      = pa_etapa
     and pa_truta      = @i_truta
     and A.es_estacion = B.es_estacion
     and A.es_estacion = @i_estacion
     and B.es_usuario  = fu_login
     and fu_estado     = 'V'
     
   select @w_retorno_of
   return 0
end


ERROR:
exec cobis..sp_cerror 
@t_debug = 'N', 
@t_file = null,
@t_from = @w_sp_name,
@i_num  = @w_error,
@i_msg  = @w_msg
return @w_error      

go
