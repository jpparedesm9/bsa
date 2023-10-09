    #region Copyright (c) 2010 COBIS Corporation.
    /************************************************************/
    /*                     IMPORTANTE                           */
    /*   Esta aplicacion es parte de los  paquetes bancarios    */
    /*   propiedad de COBISCORP.                                */
    /*   Su uso no autorizado queda  expresamente  prohibido    */
    /*   asi como cualquier alteracion o agregado hecho  por    */
    /*   alguno de sus usuarios sin el debido consentimiento    */
    /*   por escrito de COBISCORP.                              */
    /*   Este programa esta protegido por la ley de derechos    */
    /*   de autor y por las y por las convenciones              */
    /*   internacionales de  propiedad intelectual. Su uso no   */
    /*   autorizado dara  derecho a  COBISCORP para obtener     */
    /*   ordenes de  secuestro o retencion y  para perseguir    */
    /*   penalmente a los autores de cualquier infraccion.      */
    /************************************************************/
    /*   This code was generated by CSG.                        */
    /*   Changes to this file may cause incorrect behavior      */
    /*   and will be lost if the code is regenerated.           */
    /************************************************************/
    #endregion

    using System;
    using System.Web.Services;
	using System.Web.Configuration;
    using System.Collections.Generic;
    using System.Collections;
    using COBISCorp.eCOBIS.Commons.BLI.DTO;
    using COBISCorp.eCOBIS.MobileServices.MapWS;
    using COBISCorp.eCOBIS.Commons.BLIMAPWS;
    using COBISCorp.eCOBIS.Commons.BLIMAPWSMAPWS.Logger;
    using COBISCorp.eCOBIS.Commons.BLIMAPWSMAPWS.Exceptions;
    using log4net;
    using ns0 = COBISCorp.eCOBIS.Admin.CtasCteAho.DTO;
    
	namespace COBISCorp.eCOBIS.Admin.CtasCteAho.BLI.Impl
	{
    	[WebService(Namespace = "http://tempuri.org/")]
        [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
        public class BLIAhorros : BLService, IBLIAhorros
    	{
			private static readonly ILog log = LogManager.GetLogger(typeof(BLIAhorros));

			[WebMethod]
			public ns0.ConsultaMovimientosResponse ConsultaMovimientos(ns0.ConsultaMovimientoRequest inConsultaMovimientoRequest)
			{
				#region Variables
				int status = -99;
      			short sqlSession = -99;
      			MapWSMapper Mapper;
				ns0.ConsultaMovimientosResponse response = new ns0.ConsultaMovimientosResponse();
				#endregion
		
				#region Session				
				try
	      		{
					string kernelName = WebConfigurationManager.AppSettings["KernelName"];
			        sqlSession = MapWSUtil.FMRpcInit(kernelName + ".cob_interfase.sp_ahconsmov", 4168);
				}
				catch (Exception ex)
				{
					log.Error("Error inicializando servicio", ex);
					throw new BLIException("Error inicializando servicio", ex);
				}
				if(sqlSession < 0)
				{
					throw new BLIException("sesi�n inv�lida: " + sqlSession);
				}
				#endregion
		
				#region Input Parameters
				try
	      		{
					Mapper = new MapWSMapper(sqlSession);
		        	Mapper.AddInParameter("@t_trn", 56, true, "4168");
					if(inConsultaMovimientoRequest.NumCuenta != null)
						Mapper.AddInParameter("@i_cta", 39, false, inConsultaMovimientoRequest.NumCuenta);
					Mapper.AddInParameter("@i_mon", 48, false, inConsultaMovimientoRequest.Moneda, true);
					if(inConsultaMovimientoRequest.Desde != null)
						Mapper.AddInParameter("@i_fchdsde", 61, false, inConsultaMovimientoRequest.Desde);
					if(inConsultaMovimientoRequest.Hasta != null)
						Mapper.AddInParameter("@i_fchhsta", 61, false, inConsultaMovimientoRequest.Hasta);
					Mapper.AddInParameter("@i_sec", 56, false, inConsultaMovimientoRequest.Sec, true);
					Mapper.AddInParameter("@i_sec_alt", 56, false, inConsultaMovimientoRequest.SecAlt, true);
					if(inConsultaMovimientoRequest.Hora != null)
						Mapper.AddInParameter("@i_hora", 58, false, inConsultaMovimientoRequest.Hora);
					Mapper.AddInParameter("@i_diario", 48, false, inConsultaMovimientoRequest.Diario, true);
					if(inConsultaMovimientoRequest.FormatoFecha != null)
						Mapper.AddInParameter("@i_formato_fecha", 48, false, inConsultaMovimientoRequest.FormatoFecha);
				}
				catch (Exception ex)
				{
					log.Error("Error en parametros servicio", ex);
					throw new BLIException("Error en parametros servicio", ex);
				}
				#endregion
		
				#region Ejecucion
				object[,] obj = null;
        
				try
	      		{
					List<object[,]> objs = Mapper.ExecuteProcedure(5, "b426b30042abbc15e363cb679bbc937d", out status);
					if(status <= 0)
					{
						response.Success = false;
					}				
					else
					{
						response.Success = true;
						#region Results
						{
							obj = objs[4];
							List<ns0.Movimiento> data = Mapper.GetObjectList<ns0.Movimiento>(obj,"Fecha","Causa","Oficina","Correccion","Descripcion","Signo","Valor","Terminal","SaldoContable","SaldoDisponible","Interes","SsnBranch","CodAlterno","Serial","Secuencial","Usuario","Hora",null,null,"ValorComision","MontoImp");
							response.Movimientos = data.ToArray();				
						}
						#endregion
						#region Outputs
						Dictionary<string, string> outputs = Mapper.GetOutParams();
						if (outputs.ContainsKey("@o_hist"))
    					{
							SetPropertyValue(outputs["@o_hist"], response, "Hist");
						}
						#endregion
					}
					response.Messages = Mapper.GetMessages().ToArray();
      				return response;
				}
				catch (Exception ex)
				{
					log.Error("Error en la llamada al servicio ", ex);
					throw new BLIException("Exception in service", ex);
				}
				finally {
					Mapper.FinalizeTransaction();
				}
				#endregion
			}
			[WebMethod]
			public ns0.SaldoYPromedioResponse ConsultaSaldosYPromedios(ns0.SaldoYPromedioRequest inSaldoYPromedioRequest)
			{
				#region Variables
				int status = -99;
      			short sqlSession = -99;
      			MapWSMapper Mapper;
				ns0.SaldoYPromedioResponse response = new ns0.SaldoYPromedioResponse();
				#endregion
		
				#region Session				
				try
	      		{
					string kernelName = WebConfigurationManager.AppSettings["KernelName"];
			        sqlSession = MapWSUtil.FMRpcInit(kernelName + ".cob_interfase.sp_tr_con_saldos", 4169);
				}
				catch (Exception ex)
				{
					log.Error("Error inicializando servicio", ex);
					throw new BLIException("Error inicializando servicio", ex);
				}
				if(sqlSession < 0)
				{
					throw new BLIException("sesi�n inv�lida: " + sqlSession);
				}
				#endregion
		
				#region Input Parameters
				try
	      		{
					Mapper = new MapWSMapper(sqlSession);
		        	Mapper.AddInParameter("@t_trn", 56, true, "4169");
					if(inSaldoYPromedioRequest.NumCuenta != null)
						Mapper.AddInParameter("@i_cta", 39, false, inSaldoYPromedioRequest.NumCuenta);
					Mapper.AddInParameter("@i_mon", 48, false, inSaldoYPromedioRequest.Moneda, true);
					Mapper.AddInParameter("@i_inforcuenta", 47, false, inSaldoYPromedioRequest.InforCuenta, true);
					if(inSaldoYPromedioRequest.FormatoFecha != null)
						Mapper.AddInParameter("@i_formato_fecha", 56, false, inSaldoYPromedioRequest.FormatoFecha);
					Mapper.AddInParameter("@i_escliente", 47, false, inSaldoYPromedioRequest.EsCliente, true);
					Mapper.AddInParameter("@i_corresponsal", 47, false, inSaldoYPromedioRequest.Corresponsal, true);
				}
				catch (Exception ex)
				{
					log.Error("Error en parametros servicio", ex);
					throw new BLIException("Error en parametros servicio", ex);
				}
				#endregion
		
				#region Ejecucion
				object[,] obj = null;
        
				try
	      		{
					obj = Mapper.ExecuteProcedure("c344336196d5ec19bd54fd14befdde87", out status);
					if(status <= 0)
					{
						response.Success = false;
					}				
					else
					{
						response.Success = true;
						#region Results
						if (obj != null)
						{
							response.SaldoYPromedio = Mapper.GetObject<ns0.SaldoYPromedio>(obj,"Moneda","DesMoneda","CodEstado","DesEstado","CodCategoria","DesCategoria","OficialCta","NombreOficial","CodTipoPromedio","DesTipoPromedio","CodCapitalizacion","DesCapitalizacion","CodProdBancario","DesProdBancario","Contractual","TipoCuenta","Retenido24Horas","Retenido12Horas","Disponible","SaldoCuenta","SaldoGirar","SaldoInteres","Promedio1","Promedio2","Promedio3","Promedio4","Promedio5","Promedio6","PromedioGeneral","RetencionValores","FechaUltMovimiento","PromedioDisponible","CredHoy","CredMes","DebHoy","DebMes","IdbMes","MontoConsumos","SaldoAyer","TasaHoy","UltimoInteres","InteresMes","ValoresEmbargados","CuentaEmbargada","ValoresSuspenso","RemAyer","Patente","Fideicomiso");
						}
						#endregion
					}
					response.Messages = Mapper.GetMessages().ToArray();
      				return response;
				}
				catch (Exception ex)
				{
					log.Error("Error en la llamada al servicio ", ex);
					throw new BLIException("Exception in service", ex);
				}
				finally {
					Mapper.FinalizeTransaction();
				}
				#endregion
			}
			[WebMethod]
			public ns0.RegistroDelDepositoResponse RegistroDelDeposito(ns0.RegistroDelDepositoRequest inRegistroDelDepositoRequest)
			{
				#region Variables
				int status = -99;
      			short sqlSession = -99;
      			MapWSMapper Mapper;
				ns0.RegistroDelDepositoResponse response = new ns0.RegistroDelDepositoResponse();
				#endregion
		
				#region Session				
				try
	      		{
					string kernelName = WebConfigurationManager.AppSettings["KernelName"];
			        sqlSession = MapWSUtil.FMRpcInit(kernelName + ".cob_interfase.sp_reg_deposito_efch", 4170);
				}
				catch (Exception ex)
				{
					log.Error("Error inicializando servicio", ex);
					throw new BLIException("Error inicializando servicio", ex);
				}
				if(sqlSession < 0)
				{
					throw new BLIException("sesi�n inv�lida: " + sqlSession);
				}
				#endregion
		
				#region Input Parameters
				try
	      		{
					Mapper = new MapWSMapper(sqlSession);
					Mapper.AddInParameter("@i_operacion", 47, true, "D");
		        	Mapper.AddInParameter("@t_trn", 56, true, "4170");
					if(inRegistroDelDepositoRequest.Filial != null)
						Mapper.AddInParameter("@i_filial", 56, false, inRegistroDelDepositoRequest.Filial);
					if(inRegistroDelDepositoRequest.Fecha != null)
						Mapper.AddInParameter("@i_fecha", 61, false, inRegistroDelDepositoRequest.Fecha);
					if(inRegistroDelDepositoRequest.NumCuenta != null)
						Mapper.AddInParameter("@i_cta_banco", 39, false, inRegistroDelDepositoRequest.NumCuenta);
					if(inRegistroDelDepositoRequest.NumCuentaMig != null)
						Mapper.AddInParameter("@i_cta_mig", 39, false, inRegistroDelDepositoRequest.NumCuentaMig);
					if(inRegistroDelDepositoRequest.Efectivo != null)
						Mapper.AddInParameter("@i_efe", 60, false, inRegistroDelDepositoRequest.Efectivo);
					if(inRegistroDelDepositoRequest.ChequesPropios != null)
						Mapper.AddInParameter("@i_prop", 60, false, inRegistroDelDepositoRequest.ChequesPropios);
					if(inRegistroDelDepositoRequest.ChequesLocales != null)
						Mapper.AddInParameter("@i_loc", 60, false, inRegistroDelDepositoRequest.ChequesLocales);
					if(inRegistroDelDepositoRequest.Total != null)
						Mapper.AddInParameter("@i_total", 60, false, inRegistroDelDepositoRequest.Total);
					if(inRegistroDelDepositoRequest.ChequesOtrasPlazas != null)
						Mapper.AddInParameter("@i_plaz", 60, false, inRegistroDelDepositoRequest.ChequesOtrasPlazas);
					if(inRegistroDelDepositoRequest.Remesas != null)
						Mapper.AddInParameter("@i_remesas", 47, false, inRegistroDelDepositoRequest.Remesas);
					if(inRegistroDelDepositoRequest.SecCheque != null)
						Mapper.AddInParameter("@i_sec_chq", 56, false, inRegistroDelDepositoRequest.SecCheque);
					if(inRegistroDelDepositoRequest.CodBanco != null)
						Mapper.AddInParameter("@i_cod_banco", 52, false, inRegistroDelDepositoRequest.CodBanco);
					if(inRegistroDelDepositoRequest.CuentaCheque != null)
						Mapper.AddInParameter("@i_cta_chq", 39, false, inRegistroDelDepositoRequest.CuentaCheque);
					if(inRegistroDelDepositoRequest.NumCheque != null)
						Mapper.AddInParameter("@i_num_chq", 56, false, inRegistroDelDepositoRequest.NumCheque);
					if(inRegistroDelDepositoRequest.FechaEmision != null)
						Mapper.AddInParameter("@i_fecha_emi", 61, false, inRegistroDelDepositoRequest.FechaEmision);
					if(inRegistroDelDepositoRequest.ValorCheque != null)
						Mapper.AddInParameter("@i_valor_chq", 60, false, inRegistroDelDepositoRequest.ValorCheque);
					if(inRegistroDelDepositoRequest.SsnDeposito != null)
						Mapper.AddInParameter("@i_ssn_deposito", 56, false, inRegistroDelDepositoRequest.SsnDeposito);
					if(inRegistroDelDepositoRequest.SsnBranch != null)
						Mapper.AddInParameter("@i_ssn_branch", 56, false, inRegistroDelDepositoRequest.SsnBranch);
			Mapper.AddOutParameter("@o_ssn", 56, false, inRegistroDelDepositoRequest.OSsn);
			Mapper.AddOutParameter("@o_ssn_branch", 56, false, inRegistroDelDepositoRequest.OSsnBranch);
				}
				catch (Exception ex)
				{
					log.Error("Error en parametros servicio", ex);
					throw new BLIException("Error en parametros servicio", ex);
				}
				#endregion
		
				#region Ejecucion
				try
	      		{
					Mapper.ExecuteProcedure(0, "5f635ccf7bd8ab4ef0ed892e5af22890", out status);
					if(status <= 0)
					{
						response.Success = false;
					}				
					else
					{
						response.Success = true;
						#region Outputs
						Dictionary<string, string> outputs = Mapper.GetOutParams();
						if (outputs.ContainsKey("@o_ssn"))
    					{
							SetPropertyValue(outputs["@o_ssn"], response, "Ssn");
						}
						if (outputs.ContainsKey("@o_ssn_branch"))
    					{
							SetPropertyValue(outputs["@o_ssn_branch"], response, "SsnBranch");
						}
						#endregion
					}
					response.Messages = Mapper.GetMessages().ToArray();
      				return response;
				}
				catch (Exception ex)
				{
					log.Error("Error en la llamada al servicio ", ex);
					throw new BLIException("Exception in service", ex);
				}
				finally {
					Mapper.FinalizeTransaction();
				}
				#endregion
			}
			[WebMethod]
			public ns0.RetiroResponse RetiroAhorros(ns0.RetiroRequest inRetiroRequest)
			{
				#region Variables
				int status = -99;
      			short sqlSession = -99;
      			MapWSMapper Mapper;
				ns0.RetiroResponse response = new ns0.RetiroResponse();
				#endregion
		
				#region Session				
				try
	      		{
					string kernelName = WebConfigurationManager.AppSettings["KernelName"];
			        sqlSession = MapWSUtil.FMRpcInit(kernelName + ".cob_interfase.sp_ahretiro", 4171);
				}
				catch (Exception ex)
				{
					log.Error("Error inicializando servicio", ex);
					throw new BLIException("Error inicializando servicio", ex);
				}
				if(sqlSession < 0)
				{
					throw new BLIException("sesi�n inv�lida: " + sqlSession);
				}
				#endregion
		
				#region Input Parameters
				try
	      		{
					Mapper = new MapWSMapper(sqlSession);
		        	Mapper.AddInParameter("@t_trn", 56, true, "4171");
					if(inRetiroRequest.NumCuenta != null)
						Mapper.AddInParameter("@i_cta", 39, false, inRetiroRequest.NumCuenta);
					if(inRetiroRequest.Moneda != null)
						Mapper.AddInParameter("@i_mon", 48, false, inRetiroRequest.Moneda);
					if(inRetiroRequest.Valor != null)
						Mapper.AddInParameter("@i_val", 60, false, inRetiroRequest.Valor);
					if(inRetiroRequest.Canal != null)
						Mapper.AddInParameter("@i_canal", 48, false, inRetiroRequest.Canal);
				}
				catch (Exception ex)
				{
					log.Error("Error en parametros servicio", ex);
					throw new BLIException("Error en parametros servicio", ex);
				}
				#endregion
		
				#region Ejecucion
				try
	      		{
					Mapper.ExecuteProcedure(0, "4cfe94fcc9db2f0a16ba44fa5b71d8ec", out status);
					if(status <= 0)
					{
						response.Success = false;
					}				
					else
					{
						response.Success = true;
						#region Outputs
						Dictionary<string, string> outputs = Mapper.GetOutParams();
						if (outputs.ContainsKey("@o_ssn"))
    					{
							SetPropertyValue(outputs["@o_ssn"], response, "Ssn");
						}
						#endregion
					}
					response.Messages = Mapper.GetMessages().ToArray();
      				return response;
				}
				catch (Exception ex)
				{
					log.Error("Error en la llamada al servicio ", ex);
					throw new BLIException("Exception in service", ex);
				}
				finally {
					Mapper.FinalizeTransaction();
				}
				#endregion
			}
		}
	}