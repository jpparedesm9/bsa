/************************************************************************/  
/*   Stored procedure:     sp_ejec_maysiter                             */
/*   Base de datos:        cob_conta                                    */    
/************************************************************************/  
/*                                  IMPORTANTE                          */  
/*   Este programa es parte de los paquetes bancarios propiedad de      */  
/*   'MACOSA'                                                           */  
/*   Su uso no autorizado queda expresamente prohibido asi como         */  
/*   cualquier alteracion o agregado hecho por alguno de sus            */  
/*   usuarios sin el debido consentimiento por escrito de la            */  
/*   Presidencia Ejecutiva de MACOSA o su representante.                */  
/************************************************************************/  
/*                            PROPOSITO                                 */  
/************************************************************************/  
                                                                            
use cob_conta                                                               
go                                                                          
                                                                            
if exists (select 1 from sysobjects where name = 'sp_ejec_maysiter')        
   drop proc sp_ejec_maysiter                                               
go                                                                          
                                                                            
CREATE proc [dbo].[sp_ejec_maysiter]                                        
(                                                                           
   @i_empresa    tinyint,                                                   
   @i_fecha      datetime                                                   
)                                                                           
as                                                                          
declare @w_particion  tinyint,                                              
        @w_return     int                                                   
                                                                            
select @w_return = 0                                                        
select @w_particion = 1                                                     
                                                                            
   execute @w_return = cob_conta..sp_maysiter                               
   @i_empresa      = @i_empresa,                                            
   @i_fecha_tran   = @i_fecha,                                              
   @i_nro_procesos = @w_particion,                                          
   @i_opcion       = 0                                                      
                                                                            
   if @w_return <> 0                                                        
   begin                                                                    
      print 'Error opcion 0 sp_maysi'                                       
      return 1                                                              
   end                                                                      
                                                                            
   execute @w_return = cob_conta..sp_maysiter                               
   @i_empresa      =  @i_empresa,                                           
   @i_fecha_tran   =  @i_fecha,                                             
   @i_proceso      =  @w_particion,                                         
   @i_opcion       =  1                                                     
                                                                            
   if @w_return <> 0                                                        
   begin                                                                    
      print 'Error opcion 1 sp_maysi'                                       
      return 1                                                              
   end                                                                      
                                                                            
                                                                            
return 0                                                                    
                                                                            
go                                                                          
                                                                            
                                                                            