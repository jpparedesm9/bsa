
    #region Copyright � 2010 COBIS Corporation.
    /************************************************************/
    /*                     IMPORTANTE                           */
    /*   Esta aplicacion es parte de los  paquetes bancarios    */
    /*   propiedad de COBISCORP.                                */
    /*   Su uso no autorizado queda  expresamente  prohibido    */
    /*   asi como cualquier alteracion o agregado hecho  por    */
    /*   alguno de sus usuarios sin el debido consentimiento    */
    /*   por escrito de COBISCORP.                              */
    /*   Este programa esta protegido por la ley de derechos    */
    /*   de autor  y por las convenciones internacionales de    */
    /*   propiedad intelectual.   Su  uso no autorizado dara    */
    /*   derecho  a   COBISCORP   para  obtener  ordenes  de    */
    /*   secuestro o retencion  y  para perseguir penalmente    */
    /*   a los autores de cualquier infraccion.                 */
    /************************************************************/
    /************************************************************/
    /*   This code was generated by CEN-SG.                     */
    /*   Changes to this file may cause incorrect behavior      */
    /*   and will be lost if the code is regenerated.           */
    /************************************************************/
    #endregion
    using System.Runtime.Serialization;
using COBISCorp.eCOBIS.Commons.DataBinding;
using System.Collections.Generic;
using System.Collections;
using System;
using COBISCorp.eCOBIS.Commons.BLI.DTO;
[assembly: System.Runtime.Serialization.ContractNamespaceAttribute("http://cobiscorp.ecobis.admin.ctascteaho.dto", ClrNamespace="cobiscorp.ecobis.admin.ctascteaho.dto")]

namespace COBISCorp.eCOBIS.Admin.CtasCteAho.DTO
{
  [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "3.0.0.0")] 
  [System.Runtime.Serialization.DataContractAttribute(Namespace= "http://cobiscorp.ecobis.admin.ctascteaho.dto")]
[Serializable]
  public partial class SaldoYPromedio: ICloneable
    
 {
  public SaldoYPromedio(){
}
  private int moneda;
  private string desMoneda;
  private string codEstado;
  private string desEstado;
  private string codCategoria;
  private string desCategoria;
  private int oficialCta;
  private string nombreOficial;
  private string codTipoPromedio;
  private string desTipoPromedio;
  private string codCapitalizacion;
  private string desCapitalizacion;
  private string codProdBancario;
  private string desProdBancario;
  private string contractual;
  private string tipoCuenta;
  private double retenido24Horas;
  private double retenido12Horas;
  private double disponible;
  private double saldoCuenta;
  private double saldoGirar;
  private double saldoInteres;
  private double promedio1;
  private double promedio2;
  private double promedio3;
  private double promedio4;
  private double promedio5;
  private double promedio6;
  private double promedioGeneral;
  private double retencionValores;
  private string fechaUltMovimiento;
  private double promedioDisponible;
  private double credHoy;
  private double credMes;
  private double debHoy;
  private double debMes;
  private double idbMes;
  private double montoConsumos;
  private double saldoAyer;
  private double tasaHoy;
  private double ultimoInteres;
  private double interesMes;
  private string valoresEmbargados;
  private string cuentaEmbargada;
  private double valoresSuspenso;
  private double remAyer;
  private string patente;
  private string fideicomiso;
 [System.Runtime.Serialization.DataMemberAttribute(Name = "moneda", IsRequired = true, Order =0)] 
  public int  Moneda
   {
    get
     {
          return this.moneda;
   }
    set
     {
          this.moneda=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "desMoneda", IsRequired = true, Order =0)] 
  public string  DesMoneda
   {
    get
     {
          return this.desMoneda;
   }
    set
     {
          this.desMoneda=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "codEstado", IsRequired = true, Order =0)] 
  public string  CodEstado
   {
    get
     {
          return this.codEstado;
   }
    set
     {
          this.codEstado=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "desEstado", IsRequired = true, Order =0)] 
  public string  DesEstado
   {
    get
     {
          return this.desEstado;
   }
    set
     {
          this.desEstado=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "codCategoria", IsRequired = true, Order =0)] 
  public string  CodCategoria
   {
    get
     {
          return this.codCategoria;
   }
    set
     {
          this.codCategoria=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "desCategoria", IsRequired = true, Order =0)] 
  public string  DesCategoria
   {
    get
     {
          return this.desCategoria;
   }
    set
     {
          this.desCategoria=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "oficialCta", IsRequired = true, Order =0)] 
  public int  OficialCta
   {
    get
     {
          return this.oficialCta;
   }
    set
     {
          this.oficialCta=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "nombreOficial", IsRequired = true, Order =0)] 
  public string  NombreOficial
   {
    get
     {
          return this.nombreOficial;
   }
    set
     {
          this.nombreOficial=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "codTipoPromedio", IsRequired = true, Order =0)] 
  public string  CodTipoPromedio
   {
    get
     {
          return this.codTipoPromedio;
   }
    set
     {
          this.codTipoPromedio=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "desTipoPromedio", IsRequired = true, Order =0)] 
  public string  DesTipoPromedio
   {
    get
     {
          return this.desTipoPromedio;
   }
    set
     {
          this.desTipoPromedio=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "codCapitalizacion", IsRequired = true, Order =0)] 
  public string  CodCapitalizacion
   {
    get
     {
          return this.codCapitalizacion;
   }
    set
     {
          this.codCapitalizacion=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "desCapitalizacion", IsRequired = true, Order =0)] 
  public string  DesCapitalizacion
   {
    get
     {
          return this.desCapitalizacion;
   }
    set
     {
          this.desCapitalizacion=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "codProdBancario", IsRequired = true, Order =0)] 
  public string  CodProdBancario
   {
    get
     {
          return this.codProdBancario;
   }
    set
     {
          this.codProdBancario=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "desProdBancario", IsRequired = true, Order =0)] 
  public string  DesProdBancario
   {
    get
     {
          return this.desProdBancario;
   }
    set
     {
          this.desProdBancario=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "contractual", IsRequired = true, Order =0)] 
  public string  Contractual
   {
    get
     {
          return this.contractual;
   }
    set
     {
          this.contractual=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "tipoCuenta", IsRequired = true, Order =0)] 
  public string  TipoCuenta
   {
    get
     {
          return this.tipoCuenta;
   }
    set
     {
          this.tipoCuenta=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "retenido24Horas", IsRequired = true, Order =0)] 
  public double  Retenido24Horas
   {
    get
     {
          return this.retenido24Horas;
   }
    set
     {
          this.retenido24Horas=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "retenido12Horas", IsRequired = true, Order =0)] 
  public double  Retenido12Horas
   {
    get
     {
          return this.retenido12Horas;
   }
    set
     {
          this.retenido12Horas=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "disponible", IsRequired = true, Order =0)] 
  public double  Disponible
   {
    get
     {
          return this.disponible;
   }
    set
     {
          this.disponible=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "saldoCuenta", IsRequired = true, Order =0)] 
  public double  SaldoCuenta
   {
    get
     {
          return this.saldoCuenta;
   }
    set
     {
          this.saldoCuenta=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "saldoGirar", IsRequired = true, Order =0)] 
  public double  SaldoGirar
   {
    get
     {
          return this.saldoGirar;
   }
    set
     {
          this.saldoGirar=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "saldoInteres", IsRequired = true, Order =0)] 
  public double  SaldoInteres
   {
    get
     {
          return this.saldoInteres;
   }
    set
     {
          this.saldoInteres=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "promedio1", IsRequired = true, Order =0)] 
  public double  Promedio1
   {
    get
     {
          return this.promedio1;
   }
    set
     {
          this.promedio1=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "promedio2", IsRequired = true, Order =0)] 
  public double  Promedio2
   {
    get
     {
          return this.promedio2;
   }
    set
     {
          this.promedio2=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "promedio3", IsRequired = true, Order =0)] 
  public double  Promedio3
   {
    get
     {
          return this.promedio3;
   }
    set
     {
          this.promedio3=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "promedio4", IsRequired = true, Order =0)] 
  public double  Promedio4
   {
    get
     {
          return this.promedio4;
   }
    set
     {
          this.promedio4=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "promedio5", IsRequired = true, Order =0)] 
  public double  Promedio5
   {
    get
     {
          return this.promedio5;
   }
    set
     {
          this.promedio5=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "promedio6", IsRequired = true, Order =0)] 
  public double  Promedio6
   {
    get
     {
          return this.promedio6;
   }
    set
     {
          this.promedio6=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "promedioGeneral", IsRequired = true, Order =0)] 
  public double  PromedioGeneral
   {
    get
     {
          return this.promedioGeneral;
   }
    set
     {
          this.promedioGeneral=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "retencionValores", IsRequired = true, Order =0)] 
  public double  RetencionValores
   {
    get
     {
          return this.retencionValores;
   }
    set
     {
          this.retencionValores=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "fechaUltMovimiento", IsRequired = true, Order =0)] 
  public string  FechaUltMovimiento
   {
    get
     {
          return this.fechaUltMovimiento;
   }
    set
     {
          this.fechaUltMovimiento=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "promedioDisponible", IsRequired = true, Order =0)] 
  public double  PromedioDisponible
   {
    get
     {
          return this.promedioDisponible;
   }
    set
     {
          this.promedioDisponible=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "credHoy", IsRequired = true, Order =0)] 
  public double  CredHoy
   {
    get
     {
          return this.credHoy;
   }
    set
     {
          this.credHoy=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "credMes", IsRequired = true, Order =0)] 
  public double  CredMes
   {
    get
     {
          return this.credMes;
   }
    set
     {
          this.credMes=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "debHoy", IsRequired = true, Order =0)] 
  public double  DebHoy
   {
    get
     {
          return this.debHoy;
   }
    set
     {
          this.debHoy=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "debMes", IsRequired = true, Order =0)] 
  public double  DebMes
   {
    get
     {
          return this.debMes;
   }
    set
     {
          this.debMes=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "idbMes", IsRequired = true, Order =0)] 
  public double  IdbMes
   {
    get
     {
          return this.idbMes;
   }
    set
     {
          this.idbMes=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "montoConsumos", IsRequired = true, Order =0)] 
  public double  MontoConsumos
   {
    get
     {
          return this.montoConsumos;
   }
    set
     {
          this.montoConsumos=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "saldoAyer", IsRequired = true, Order =0)] 
  public double  SaldoAyer
   {
    get
     {
          return this.saldoAyer;
   }
    set
     {
          this.saldoAyer=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "tasaHoy", IsRequired = true, Order =0)] 
  public double  TasaHoy
   {
    get
     {
          return this.tasaHoy;
   }
    set
     {
          this.tasaHoy=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "ultimoInteres", IsRequired = true, Order =0)] 
  public double  UltimoInteres
   {
    get
     {
          return this.ultimoInteres;
   }
    set
     {
          this.ultimoInteres=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "interesMes", IsRequired = true, Order =0)] 
  public double  InteresMes
   {
    get
     {
          return this.interesMes;
   }
    set
     {
          this.interesMes=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "valoresEmbargados", IsRequired = true, Order =0)] 
  public string  ValoresEmbargados
   {
    get
     {
          return this.valoresEmbargados;
   }
    set
     {
          this.valoresEmbargados=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "cuentaEmbargada", IsRequired = true, Order =0)] 
  public string  CuentaEmbargada
   {
    get
     {
          return this.cuentaEmbargada;
   }
    set
     {
          this.cuentaEmbargada=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "valoresSuspenso", IsRequired = true, Order =0)] 
  public double  ValoresSuspenso
   {
    get
     {
          return this.valoresSuspenso;
   }
    set
     {
          this.valoresSuspenso=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "remAyer", IsRequired = true, Order =0)] 
  public double  RemAyer
   {
    get
     {
          return this.remAyer;
   }
    set
     {
          this.remAyer=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "patente", IsRequired = true, Order =0)] 
  public string  Patente
   {
    get
     {
          return this.patente;
   }
    set
     {
          this.patente=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "fideicomiso", IsRequired = true, Order =0)] 
  public string  Fideicomiso
   {
    get
     {
          return this.fideicomiso;
   }
    set
     {
          this.fideicomiso=value;
   }

 }

    #region ICloneable Members

    public object Clone()
    {
    return this.MemberwiseClone();
    }

    #endregion
    
 }
}