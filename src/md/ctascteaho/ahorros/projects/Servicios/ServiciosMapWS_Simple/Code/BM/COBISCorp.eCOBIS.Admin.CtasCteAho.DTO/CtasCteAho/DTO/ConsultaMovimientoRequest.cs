
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
  public partial class ConsultaMovimientoRequest: ICloneable
    
 {
  public ConsultaMovimientoRequest(){
}
  private DateTime desde;
  private DateTime hasta;
  private int sec;
  private int secAlt;
  private DateTime hora;
  private int diario;
  private int formatoFecha;
  private string numCuenta;
  private int moneda;
 [System.Runtime.Serialization.DataMemberAttribute(Name = "desde", IsRequired = true, Order =0)] 
  public DateTime  Desde
   {
    get
     {
          return this.desde;
   }
    set
     {
          this.desde=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "hasta", IsRequired = true, Order =0)] 
  public DateTime  Hasta
   {
    get
     {
          return this.hasta;
   }
    set
     {
          this.hasta=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "sec", IsRequired = true, Order =0)] 
  public int  Sec
   {
    get
     {
          return this.sec;
   }
    set
     {
          this.sec=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "secAlt", IsRequired = true, Order =0)] 
  public int  SecAlt
   {
    get
     {
          return this.secAlt;
   }
    set
     {
          this.secAlt=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "hora", IsRequired = true, Order =0)] 
  public DateTime  Hora
   {
    get
     {
          return this.hora;
   }
    set
     {
          this.hora=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "diario", IsRequired = true, Order =0)] 
  public int  Diario
   {
    get
     {
          return this.diario;
   }
    set
     {
          this.diario=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "formatoFecha", IsRequired = true, Order =0)] 
  public int  FormatoFecha
   {
    get
     {
          return this.formatoFecha;
   }
    set
     {
          this.formatoFecha=value;
   }

 }
 [System.Runtime.Serialization.DataMemberAttribute(Name = "numCuenta", IsRequired = true, Order =0)] 
  public string  NumCuenta
   {
    get
     {
          return this.numCuenta;
   }
    set
     {
          this.numCuenta=value;
   }

 }
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

    #region ICloneable Members

    public object Clone()
    {
    return this.MemberwiseClone();
    }

    #endregion
    
 }
}