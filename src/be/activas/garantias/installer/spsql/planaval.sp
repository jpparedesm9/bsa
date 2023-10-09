/************************************************************************/
/*	Archivo: 	        planaval.sp                             */
/*	Stored procedure:   sp_plano_avaluo                             */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:           Garantias               		        */
/*	Disenado por:       Martha Gil V.            	      	        */
/*			                                         	*/
/*	Fecha de escritura: Junio 20 de 2007  			        */
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa genera archivo plano de registro de avaluos       */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		    RAZON			*/
/*  02/06/2007  Martha Gil V.   Emisi¢n inicial                         */
/*  03/09/2007  Sandra Lievano       DEFECTO                            */
/************************************************************************/
use cob_custodia
go
if exists (select 1 from sysobjects where name = 'sp_plano_avaluo')
    drop proc sp_plano_avaluo
go
create procedure sp_plano_avaluo(
   @i_fecha_ini      datetime,
   @i_fecha_fin      datetime               
)
    
as
declare  
        @w_today             datetime,     /* fecha del dia */ 
        @w_return            int,          /* valor que retorna */
        @w_sp_name           varchar(32),  /* nombre stored proc*/
        @w_error             int        ,
        @w_oficina           smallint,
        @w_codigo_externo    varchar(64),    
        @w_operacion         varchar(24),   
        @w_cliente           int,
        @w_tipo_id           char(2),   
        @w_id                varchar(30), 
        @w_nom_cliente       varchar(254),
        @w_nom_oficina       varchar(64),
        @w_nom_regional      varchar(64),   
        @w_desc_estado       varchar(64),
        @w_estado            catalogo,  
        @w_descripcion       varchar(254),      
        @w_fec_avaluo        datetime,
        @w_fec_visita        datetime,                   
        @w_comentario        varchar(255),   
        @w_valor             money,
        @w_custodia          int,
        @w_avaluo            int,
        @w_concepto          varchar(10),
        @w_cadena_concepto   varchar(254),
        @w_contador          int 



        /* Variables */

   select @w_sp_name = 'sp_plano_avaluo'

   truncate table cu_plano_avaluos 
  
   declare cursor_garantias cursor for
       select cu_codigo_externo, op_banco,          op_cliente, 
              cu_estado,         cu_descripcion,    A.av_fec_avaluo, 
              A.av_fec_visita,   A.av_comentario,   A.av_valor, 
              op_oficina,        cu_custodia,       av_avaluo
       from   cu_avaluos A, cu_custodia, cob_cartera..ca_operacion, cob_credito..cr_gar_propuesta
       where  A.av_fec_avaluo >= @i_fecha_ini and A.av_fec_avaluo <= @i_fecha_fin
       and   A.av_custodia = cu_codigo_externo --DEF.SLI 
       and   gp_garantia = cu_codigo_externo  
       and   op_tramite = gp_tramite 
       and  A.av_avaluo = (select max(B.av_avaluo) from cu_avaluos B where B.av_custodia = A.av_custodia and B.av_fec_avaluo >= @i_fecha_ini and B.av_fec_avaluo <= @i_fecha_fin)
        
      open cursor_garantias
      fetch cursor_garantias into  
        @w_codigo_externo,    @w_operacion,    @w_cliente,
        @w_estado,            @w_descripcion,  @w_fec_avaluo,
        @w_fec_visita,        @w_comentario,   @w_valor,
        @w_oficina,           @w_custodia,     @w_avaluo

     while @@fetch_status = 0
      begin
        if @@fetch_status = -1
          begin
             close cursor_garantias
            deallocate cursor_garantias
            goto ERROR
          end 

      select @w_nom_oficina = of_nombre
         from  cobis..cl_oficina
         where of_oficina = @w_oficina
           set transaction isolation level read uncommitted

      select @w_nom_regional = B.of_nombre
         from  cobis..cl_oficina A, cobis..cl_oficina B
         where A.of_oficina = @w_oficina
           and A.of_regional = B.of_oficina
           set transaction isolation level read uncommitted
             
      select @w_tipo_id     =  en_tipo_ced,
             @w_id          =  en_ced_ruc,
             @w_nom_cliente =  en_nomlar 
      from cobis..cl_ente
      where en_ente = @w_cliente
      set transaction isolation level read uncommitted

       select @w_desc_estado = b.codigo
       from   cobis..cl_tabla a, cobis..cl_catalogo b
       where  a.codigo = b.tabla
       and    a.tabla = 'cu_est_custodia'
       and    b.codigo = @w_estado
       
       select @w_contador = 0, @w_cadena_concepto = ""

       declare cursor_conceptos cursor for
       
       select ca_concepto 
       from cu_concepto_avaluo where ca_custodia = @w_codigo_externo and  ca_avaluo = @w_avaluo
        
       open cursor_conceptos
       fetch cursor_conceptos into  @w_concepto
          
       while @@fetch_status = 0
          begin
            
            select @w_cadena_concepto = @w_cadena_concepto + @w_concepto + " - "                
            select @w_contador =  @w_contador + 1
            
            if @w_contador = 20
              begin
                close cursor_conceptos
                deallocate cursor_conceptos
                break
              end 
            
            fetch cursor_conceptos into @w_concepto      
                
          end   --  FIN DEL WHILE
          
          close cursor_conceptos
          deallocate cursor_conceptos  
       
       
    
        insert into cu_plano_avaluos
         (
            av_codigo_externo,  av_operacion,       av_cliente,     
            av_tipo_id,         av_id,              av_nom_cliente, 
            av_nom_oficina,     av_nom_regional,    av_estado,          
            av_descripcion,     av_fec_avaluo,      av_fec_visita,                   
            av_comentario,      av_valor,           av_concepto                                            
          )    
          values( 
            @w_codigo_externo,  @w_operacion,       @w_cliente,     
            @w_tipo_id,         @w_id,              @w_nom_cliente, 
            @w_nom_oficina,     @w_nom_regional,    @w_estado,          
            @w_descripcion,     convert(varchar(10),@w_fec_avaluo,103),      
            convert(varchar(10),@w_fec_visita,103),
            @w_comentario,      @w_valor,           @w_cadena_concepto           
           )

          if @@error <> 0 
          begin
                goto ERROR
          end

          goto SIGUIENTE
ERROR:    
print "Error"

SIGUIENTE:
      fetch cursor_garantias into  
        @w_codigo_externo,    @w_operacion,    @w_cliente,
        @w_estado,            @w_descripcion,  @w_fec_avaluo,
        @w_fec_visita,        @w_comentario,   @w_valor,
        @w_oficina,           @w_custodia,     @w_avaluo        
        
 end   --  FIN DEL WHILE
      
      close cursor_garantias
      deallocate cursor_garantias


   
  return 0   
go
    
           

