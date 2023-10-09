Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Public Class CobisSharedModule
    Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
    Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
        MCOMMON.MCommonLoad()
        MyBase.LoadComponent(sender, componentEventArgs)
    End Sub
End Class
Public Module SharedFuncionalities
    Public ReadOnly Property FTran201() As FTran201Class
        Get
            Return FTran201Class.GetInstance(Of FTran201Class)()
        End Get
    End Property
    Public ReadOnly Property FTran357() As FTran357Class
        Get
            Return FTran357Class.GetInstance(Of FTran357Class)()
        End Get
    End Property
    Public ReadOnly Property FTran433() As FTran433Class
        Get
            Return FTran433Class.GetInstance(Of FTran433Class)()
        End Get
    End Property
    Public ReadOnly Property FMotorBusq() As FMotorBusqClass
        Get
            Return FMotorBusqClass.GetInstance(Of FMotorBusqClass)()
        End Get
    End Property
    Public ReadOnly Property FCausaLev() As FCausaLevClass
        Get
            Return FCausaLevClass.GetInstance(Of FCausaLevClass)()
        End Get
    End Property

    Public ReadOnly Property FTran203() As FTran203Class
        Get
            Return FTran203Class.GetInstance(Of FTran203Class)()
        End Get
    End Property
    Public ReadOnly Property FTran211() As FTran211Class
        Get
            Return FTran211Class.GetInstance(Of FTran211Class)()
        End Get
    End Property
    Public ReadOnly Property FTran212() As FTran212Class
        Get
            Return FTran212Class.GetInstance(Of FTran212Class)()
        End Get
    End Property
    Public ReadOnly Property FTran214() As FTran214Class
        Get
            Return FTran214Class.GetInstance(Of FTran214Class)()
        End Get
    End Property
    Public ReadOnly Property FTran217() As FTran217Class
        Get
            Return FTran217Class.GetInstance(Of FTran217Class)()
        End Get
    End Property
    Public ReadOnly Property FTran218() As FTran218Class
        Get
            Return FTran218Class.GetInstance(Of FTran218Class)()
        End Get
    End Property
    Public ReadOnly Property FTran351() As FTran351Class
        Get
            Return FTran351Class.GetInstance(Of FTran351Class)()
        End Get
    End Property
    Public ReadOnly Property FTRAN354() As FTRAN354Class
        Get
            Return FTRAN354Class.GetInstance(Of FTRAN354Class)()
        End Get
    End Property
    Public ReadOnly Property FTRAN41() As FTRAN41Class
        Get
            Return FTRAN41Class.GetInstance(Of FTRAN41Class)()
        End Get
    End Property
    Public ReadOnly Property FTRAN76() As FTRAN76Class
        Get
            Return FTRAN76Class.GetInstance(Of FTRAN76Class)()
        End Get
    End Property
    Public ReadOnly Property FReversos() As FReversosClass
        Get
            Return FReversosClass.GetInstance(Of FReversosClass)()
        End Get
    End Property
    Public ReadOnly Property FTRANDetalleCheque() As FTRANDetalleChequeClass
        Get
            Return FTRANDetalleChequeClass.GetInstance(Of FTRANDetalleChequeClass)()
        End Get
    End Property
End Module
