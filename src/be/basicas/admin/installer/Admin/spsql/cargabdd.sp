/************************************************************************/
/*	Archivo: 	        cargabdd.sp                             */
/*	Stored procedure:       sp_cargabdd                             */
/*	Base de datos:  	cobis				        */
/*	Producto:                             		                */
/*	Disenado por:           Cecilia Villacres                       */
/*	Fecha de escritura:     Febrero/03  				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO			        */
/*		                                                        */
/*	      sp que permite  extraer el campo name de la base          */
/*	      sysdatabases                                               */
/*	                                                                */
/*		                                                        */
/************************************************************************/
/*				MODIFICACIONES				*/
/*      FECHA       AUTOR		 RAZON		                */
/*  	                                                                */
/************************************************************************/



use master
go

if exists (select * from sysobjects where name = 'sp_cargabdd')
   drop proc sp_cargabdd
go
create proc sp_cargabdd (
   @s_date               datetime    = null,
   @t_trn                int    = null,
   @t_debug              char(1)     = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)     = null,
   @i_tipo               varchar(64) = null --,
   -- @i_modo               smallint = null
   
)
as
declare
   @w_today           datetime,       -- fecha del dfa
   @w_return          int,
   @w_sp_name         varchar(32),    -- nombre stored proc
   @w_existe          tinyint,        -- existe el registro
   @w_error           int
  
    

select @w_today   = @s_date
select @w_sp_name = 'sp_cargabdd'

if @i_operacion = 'S'
   begin
         select  
         'Prueba' = 'BASE' ,
         'Base Datos' = name
         from sysdatabases

   if @@rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 107099  
         return 1
      end
  end


return 0 

go
