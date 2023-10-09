/************************************************************************/
/*	Archivo: 		seccerti.sp                             */
/*	Stored procedure: 	sp_seccerti                             */
/*	Base de datos:  	cob_conta                               */
/*	Producto:               CONTABILIDAD                            */
/*	Disenado por:           Wladimir Ruiz G.                        */
/*	Fecha de escritura:     07/Mayo/2004                            */
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de   */
/*	"MACOSA", representantes exclusivos para el Ecuador de          */
/*	"MACOSA".                                                       */
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/* Permite obtener un secuencial cuando se ejecuta un certificado en la */
/* las hojas Excel de Contabilidad.                                     */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	12-Oct-05	Orios   	Corrección de secuenciales por  */
/*                                      tipo de certificado y anio      */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_seccerti')
	drop proc sp_seccerti
go

create proc sp_seccerti (
        @s_ssn                  int             = NULL,
        @s_user                 login           = NULL,
        @s_term                 varchar(30)     = NULL,
        @s_date                 datetime        = NULL,
        @s_sesn                 int             = NULL,
        @s_ssn_branch           int             = null,
        @s_srv                  varchar(30)     = NULL,
        @s_lsrv                 varchar(30)     = NULL,
        @s_ofi                  smallint        = NULL,
        @s_rol                  smallint        = NULL,
        @t_debug                char(1)         = 'N',
        @t_file                 varchar(10)     = NULL,
        @t_from                 varchar(32)     = NULL,
        @t_trn                  smallint        = NULL,
        @i_operacion            char(1)         = NULL,
        @i_empresa              tinyint         = 1,
        @i_modulo               tinyint         = 6,
        @i_secuencial		int     	= NULL,
        @i_oficina 		smallint     	= NULL,
	@i_certificado          varchar(20)     = NULL,
	@i_nit                  varchar(30)     = NULL,
	@i_tiponit              char(2)         = NULL,
	@i_fecha_ini            datetime        = NULL,
	@i_fecha_fin            datetime        = NULL,
        @i_tabla                varchar(30)     = NULL,
        @i_fechamaxexp          datetime        = NULL,

        @o_siguiente 		int             = NULL out,
        @o_fechamaxexp          datetime        = NULL out
)
as


/*DECLARACION DE VARIABLES TEMPORALES*/
declare @w_sp_name              varchar(32),
        @w_return		        int,
        @w_secuencial           int,
        @w_fechamaxexp          datetime,
        @w_certificado          varchar(20),
        @w_nit                  varchar(30),
        @w_tiponit              char(2),
    	@w_fecha_ini            datetime,
	@w_fecha_fin            datetime,
	@w_fecha                datetime,
	@w_anio                 int

/*INICIALIZACION DE VARIABLES TEMPORALES*/
select @w_sp_name    = 'sp_seccerti'


/**  VERIFICAR CODIGO DE TRANSACCION DE ACTIVACION  **/
if   (@t_trn != 6950) and (@i_operacion = 'E')
begin
   exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
                         @t_from  = @w_sp_name, @i_num = 607123
   return 1
end

--------------------------------
--CONSULTA EXCEL
-------------------------------
if @i_operacion = 'E'
begin

/*
    print '@i_certificado      :%1!',@i_certificado
    print '@i_nit              :%1!',@i_nit
    print '@i_tiponit          :%1!',@i_tiponit
    print '@i_fecha_ini        :%1!',@i_fecha_ini
    print '@i_fecha_fin        :%1!',@i_fecha_fin
    print '@i_certificado      :%1!',@i_certificado
    print '@i_oficina          :%1!',@i_oficina
    print '@i_fechamaxexp      :%1!', @i_fechamaxexp
    
*/
    select @w_anio = datepart(yy,@i_fecha_ini)
    
          select   @w_secuencial   = se_secuencial,
       		       @w_certificado  = se_certificado,
        	       @w_nit          = se_nit,
		           @w_tiponit      = se_tiponit,
		           @w_fecha_ini    = se_fecha_ini,
		           @w_fecha_fin    = se_fecha_fin
	       from cob_conta..cb_secuencerti
	       where  se_certificado = @i_certificado
		   and   se_nit          = @i_nit
		   and   se_tiponit      = @i_tiponit
		   and   se_fecha_ini    = @i_fecha_ini
		   and   se_fecha_fin    = @i_fecha_fin


    	   if @@rowcount <> 0 --CUANDO YA EXISTE UN SECUENCIAL LO RETORNA
	        begin
                 select  @w_secuencial,
       			 @w_certificado,
        		 @w_nit,
			 @w_tiponit,
			 @w_fecha_ini,
			 @w_fecha_fin,
			 'C',
			  convert(varchar(10),@w_fechamaxexp,101)
			  
			  return 0
	         end
	         
	   --CUANDO NO EXISTE UN SECUENCIAL
	   
	   -- verifica si existe seqnos para el anio y  tipo de certificado
	       
           if  exists (select sc_actual 
		   from cob_conta..cb_seqnos_comprobante
		   where sc_empresa  = @i_empresa
                   and   sc_tabla    = @i_tabla
                   and   sc_modulo   = @i_modulo
                   and   sc_oficina  = @w_anio ) 
                           
                           
           begin  -- existe seqnos para este anio y tipo de certificado
           
           -- busca la fecha de expedicion
                
                if exists (select fc_fecha_maxexp   
                          from cob_conta..cb_fechas_certificados
                          where fc_anno = @i_oficina
                          and fc_fecha_maxexp  = @i_fechamaxexp)
                begin
                               select @w_fechamaxexp = fc_fecha_maxexp
                               from cob_conta..cb_fechas_certificados
                               where fc_anno        = @i_oficina
                               and fc_fecha_maxexp  = @i_fechamaxexp
                end
                else
                begin
                               update cob_conta..cb_fechas_certificados
                               set fc_fecha_maxexp  = @i_fechamaxexp
                               where fc_fecha_maxexp  <> @i_fechamaxexp
                               and   fc_anno          = @i_oficina

                               select @w_fechamaxexp = fc_fecha_maxexp
                               from cob_conta..cb_fechas_certificados
                               where fc_anno        = @i_oficina
                               and fc_fecha_maxexp  = @i_fechamaxexp
                end

             -- busca el siguiente seqnos 
			               
		select @o_siguiente = isnull(max(sc_actual),0)  + 1
		from cob_conta..cb_seqnos_comprobante
		where sc_empresa  = @i_empresa
                and   sc_tabla    = @i_tabla
                and   sc_modulo   = @i_modulo
                and   sc_oficina  = @w_anio

                /* mensaje si secuencial llega al limite */
      	        if @o_siguiente = 2147483647
       	        begin
      	           print 'Secuencial llego al limite'
       	           return 1
       	        end
       		        
       		/* actualiza secuencial siguiente de la tabla */

		update cb_seqnos_comprobante
		set sc_actual     =  @o_siguiente
		where sc_empresa  = @i_empresa
                and   sc_tabla    = @i_tabla
                and   sc_modulo   = @i_modulo
                and   sc_oficina  = @w_anio
       		
       		/* si no se puede realizar la actualizacion, error */
		if @@error != 0
	          begin
	                 exec cobis..sp_cerror
	                 @t_debug = @t_debug,
	       	         @t_file  = @t_file,
	                 @t_from  = @w_sp_name,
	                 @i_num   = 105001
	           	 return 1
		   end


                   insert cob_conta..cb_secuencerti
                         (se_secuencial, se_certificado, se_nit, se_tiponit,se_fecha_ini , se_fecha_fin)
     		         values (@o_siguiente, @i_certificado, @i_nit, @i_tiponit,@i_fecha_ini , @i_fecha_fin)
                         if @@error <> 0
         	         begin
         	               /* Error en insercion de registro */
             	               exec cobis..sp_cerror
             	              @t_debug = @t_debug,
             	              @t_file  = @t_file,
             	              @t_from  = @w_sp_name,
             	              @i_num   = 601161
             	              return 1
         	         end
           end  --fin existe el seqnos
           else -- no existe el seqnos para este anio
	   begin
                 if not exists (select fc_fecha_maxexp
                                from cob_conta..cb_fechas_certificados
                               where fc_anno = @i_oficina)
                 begin
                   if @i_fechamaxexp is not null
                     begin
                       insert into cob_conta..cb_fechas_certificados (fc_certificado, fc_fecha_maxexp, fc_anno)
                       values (@i_certificado,@i_fechamaxexp,@i_oficina)

                       select @w_fechamaxexp = fc_fecha_maxexp
                       from cob_conta..cb_fechas_certificados
                       where fc_anno 	      = @i_oficina
                       and fc_fecha_maxexp  = @i_fechamaxexp
                    end   
                 end
                    
                 insert into cb_seqnos_comprobante(sc_empresa,sc_fecha,sc_tabla,sc_modulo,sc_actual,sc_oficina)
                 values (@i_empresa,getdate(),@i_tabla,@i_modulo,1,@w_anio)
                        
                 if @@error <> 0
      	           begin
        		   /* Error en insercion de registro */
            		      exec cobis..sp_cerror
             		      @t_debug = @t_debug,
             		      @t_file  = @t_file,
             		      @t_from  = @w_sp_name,
             		      @i_num   = 601161
             		      return 1
       	            end

                    insert cb_secuencerti (se_secuencial, se_certificado, se_nit, se_tiponit,se_fecha_ini , se_fecha_fin)
     	                values(1, @i_certificado, @i_nit, @i_tiponit,@i_fecha_ini , @i_fecha_fin)
                    if @@error <> 0
        	    begin
         		   /* Error en insercion de registro */
             		      exec cobis..sp_cerror
             		      @t_debug = @t_debug,
             		      @t_file  = @t_file,
             		      @t_from  = @w_sp_name,
             		      @i_num   = 601161
             		      return 1
         	    end

                   select @o_siguiente = 1
                         
   	   end --nuevo secuencial para año

                   select @o_siguiente,
    			  @i_certificado,
        		  @i_nit,
			  @i_tiponit,
			  @i_fecha_ini,
			  @i_fecha_fin,
			  'N',
                          convert(varchar(10),@w_fechamaxexp,101) 	   
  	   
           --       end 
           --    end   
end
return 0
go
