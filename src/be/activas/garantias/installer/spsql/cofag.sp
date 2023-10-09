/************************************************************************/
/*	Archivo: 	        cofag.sp                                */
/*	Stored procedure:       sp_cofag                                */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               Garantias               		*/
/*	Disenado por:           Jennifer Velandia            	      	*/
/*			                                         	*/
/*	Fecha de escritura:     Diciembre-26-2002  			*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa genera tabla  de FAG cuyo orcentaje de cubrimiento*/
/* es inferior a solicitado, para solicitar una nueva garantia          */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/
use cob_custodia
go
if exists (select 1 from sysobjects where name = 'sp_cofag')
    drop proc sp_cofag
go
create procedure sp_cofag(
        @s_ssn                int          = null,
        @s_date               datetime     = null,
        @s_user               login        = null,
        @s_term               varchar(64)  = null,
        @s_corr               char(1)      = null,
        @s_ssn_corr           int          = null,
        @s_ofi                smallint     = null,
        @t_rty                char(1)      = null,
        @t_trn                smallint     = null,
        @t_file               varchar(14)  = null,
        @i_fechai             datetime     = null,
        @i_fechaf             datetime     = null )
    
as
declare  
        @w_today              datetime,     /* fecha del dia */ 
        @w_return             int,          /* valor que retorna */
        @w_sp_name            varchar(32),  /* nombre stored proc*/
        @w_error              int        ,

        /* Variables */
        
        @w_codigo_externo       varchar(64)     ,
        @w_codigo_externo_ant   varchar(64)     ,
        @w_propietario          varchar(64)     ,
        @w_valor_actual         money           ,
        @w_oficina              smallint        ,
        @w_porcentaje           float           , 
        @w_porcentaje_ult       float           , 
        @w_tr_estado            char(1)         ,
        @w_tramite              int             ,
        @w_fag                  descripcion     , 
       	@w_cuenta               int 
	        
                    

select @w_today   = @s_date
select @w_sp_name = 'sp_cofag'

   /* parametros */
   select @w_fag   = pa_nemonico    -- FAG
     from cobis..cl_parametro
    where pa_producto = 'GAR'
      and pa_nemonico = 'FAG'
      set transaction isolation level read uncommitted


    create table #superior (tipo varchar(64))

    insert into #superior
    select tc_tipo
    from cu_tipo_custodia
    where (tc_tipo_superior = @w_fag) 
    order by tc_tipo

      
   select @w_cuenta = 0
   select @w_codigo_externo_ant = ' '
         
   truncate table cu_solicifagw 
            
      declare cursor_fag cursor for
       select 
         cu_codigo_externo,      cu_propietario,     	cu_valor_inicial ,              
	 cu_oficina ,            porcentaje,             tr_estado   ,
	 tr_tramite                  
         from cu_custodia, cob_credito..ts_gar_propuesta , 
              cob_credito..cr_tramite ,cob_credito..cr_gar_propuesta 
         where cu_tipo in (select tipo from #superior)
                and tr_estado in ('A','Z')
                and  gp_garantia = garantia
                and gp_tramite  = tr_tramite
                and cu_codigo_externo = garantia 
                and (fecha >= @i_fechai and  fecha <= @i_fechaf) 
             -- and fecha <> null   
                order by  garantia , fecha , cu_codigo_externo
                for read only            

      open cursor_fag
      fetch cursor_fag into
        @w_codigo_externo,      @w_propietario,     	@w_valor_actual ,              
	@w_oficina ,            @w_porcentaje,          @w_tr_estado,
        @w_tramite
                  
     
         
     while @@fetch_status = 0
      begin
        if @@fetch_status = -1
          begin
                select @w_error = 2101015
                close cursor_fag
                deallocate cursor_fag
                goto ERROR
         
          end
         
         
         if @w_cuenta = 0
         and @w_codigo_externo_ant = ' '
           begin              
              insert into cu_solicifagw  (
               cu_con_codigo_externo,  cu_con_nombre,     cu_con_valorgar ,             	
               cu_con_porini,          cu_con_porfin,     cu_con_estad ,     
	       cu_con_oficina,         cu_con_tramite     )     
            
               values( 
               @w_codigo_externo,      @w_propietario,    @w_valor_actual , 
               @w_porcentaje,          null,              @w_tr_estado ,
	       @w_oficina,             @w_tramite   )    
	       	          	                                        
               select @w_cuenta = @w_cuenta + 1
               select @w_codigo_externo_ant = @w_codigo_externo
             end
         else
         begin
           if  @w_codigo_externo_ant = @w_codigo_externo
              begin 
              select @w_cuenta = @w_cuenta + 1
              select @w_porcentaje_ult = @w_porcentaje
              end
           else
              begin       /* cambio de garantia */
                if   @w_cuenta  = 1
                       delete cu_solicifagw where
                        cu_con_codigo_externo  = @w_codigo_externo_ant
                    else
                     begin
                      
                     update cu_solicifagw
                     set cu_con_porfin = @w_porcentaje_ult
                     where cu_con_codigo_externo  = @w_codigo_externo_ant
                     
                     select @w_porcentaje_ult= 0
                     
                     insert into cu_solicifagw  (
                     cu_con_codigo_externo,  cu_con_nombre,     cu_con_valorgar ,             	
                     cu_con_porini,          cu_con_porfin,     cu_con_estad ,     
	             cu_con_oficina ,        cu_con_tramite )     
            
                     values( 
                     @w_codigo_externo,      @w_propietario,    @w_valor_actual , 
                     @w_porcentaje,          null,              @w_tr_estado ,
	             @w_oficina ,            @w_tramite  )    
	                                     
                     select @w_cuenta =  1
                     select @w_codigo_externo_ant = @w_codigo_externo
                     
                     end  
              end   
         end    
                                        
        fetch cursor_fag into
        @w_codigo_externo,      @w_propietario,     	@w_valor_actual ,              
	@w_oficina ,            @w_porcentaje,          @w_tr_estado,
	@w_tramite
       

 end   --  FIN DEL WHILE

      close cursor_fag
      deallocate cursor_fag
      
    if   @w_cuenta  = 1
          delete cu_solicifagw where
          cu_con_codigo_externo  = @w_codigo_externo_ant
    else
          update cu_solicifagw
          set cu_con_porfin = @w_porcentaje_ult
          where cu_con_codigo_externo  = @w_codigo_externo_ant  
 
  return 0
ERROR:    /* RUTINA QUE DISPARA sp_cerror DADO EL CODIGO DEL ERROR */
   exec cobis..sp_cerror             
   @t_from  = @w_sp_name, 
   @i_num   = @w_error
   return 1 
go
    
           
