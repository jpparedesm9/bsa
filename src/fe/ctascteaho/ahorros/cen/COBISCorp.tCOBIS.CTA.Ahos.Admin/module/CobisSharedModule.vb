Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Public Class CobisSharedModule
    Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
    Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
        MCOMMON.MCommonLoad()
        MyBase.LoadComponent(sender, componentEventArgs)
    End Sub
End Class
Public Module SharedFuncionalities
    Public ReadOnly Property FRTACIFIN() As FRTACIFINClass
        Get
            Return FRTACIFINClass.GetInstance(Of FRTACIFINClass)()
        End Get
    End Property
    Public ReadOnly Property FCtaBcoOfi() As FCtaBcoOfiClass
        Get
            Return FCtaBcoOfiClass.GetInstance(Of FCtaBcoOfiClass)()
        End Get
    End Property
    Public ReadOnly Property FMantenimiento() As FMantenimientoClass
        Get
            Return FMantenimientoClass.GetInstance(Of FMantenimientoClass)()
        End Get
    End Property
    Public ReadOnly Property FPARAMDTN() As FPARAMDTNClass
        Get
            Return FPARAMDTNClass.GetInstance(Of FPARAMDTNClass)()
        End Get
    End Property
    Public ReadOnly Property FPExenGMF() As FPExenGMFClass
        Get
            Return FPExenGMFClass.GetInstance(Of FPExenGMFClass)()
        End Get
    End Property
    Public ReadOnly Property FTran2585() As FTran2585Class
        Get
            Return FTran2585Class.GetInstance(Of FTran2585Class)()
        End Get
    End Property
    Public ReadOnly Property FTran2589() As FTran2589Class
        Get
            Return FTran2589Class.GetInstance(Of FTran2589Class)()
        End Get
    End Property
    Public ReadOnly Property FTran2593() As FTran2593Class
        Get
            Return FTran2593Class.GetInstance(Of FTran2593Class)()
        End Get
    End Property
    Public ReadOnly Property FTran099() As FTran099Class
        Get
            Return FTran099Class.GetInstance(Of FTran099Class)()
        End Get
    End Property
    Public ReadOnly Property FTranUpGMF() As FTranUpGMFClass
        Get
            Return FTranUpGMFClass.GetInstance(Of FTranUpGMFClass)()
        End Get
    End Property
End Module
