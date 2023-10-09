Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Public Class CobisSharedModule
    Inherits COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISModule(Of CobisSharedModule)
    Public Overrides Sub LoadComponent(ByVal sender As Object, ByVal componentEventArgs As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComponentEventArgs)
        MCOMMON.MCommonLoad()
        MyBase.LoadComponent(sender, componentEventArgs)
    End Sub
End Class
Public Module SharedFuncionalities
    Public ReadOnly Property FTran432() As FTran432Class
        Get
            Return FTran432Class.GetInstance(Of FTran432Class)()
        End Get
    End Property
    Public ReadOnly Property FTran407() As FTran407Class
        Get
            Return FTran407Class.GetInstance(Of FTran407Class)()
        End Get
    End Property
    Public ReadOnly Property FTran408() As FTran408Class
        Get
            Return FTran408Class.GetInstance(Of FTran408Class)()
        End Get
    End Property
    Public ReadOnly Property FTran410() As FTran410Class
        Get
            Return FTran410Class.GetInstance(Of FTran410Class)()
        End Get
    End Property
    Public ReadOnly Property FTran417() As FTran417Class
        Get
            Return FTran417Class.GetInstance(Of FTran417Class)()
        End Get
    End Property
    Public ReadOnly Property FTran429() As FTran429Class
        Get
            Return FTran429Class.GetInstance(Of FTran429Class)()
        End Get
    End Property
    Public ReadOnly Property FTran601() As FTran601Class
        Get
            Return FTran601Class.GetInstance(Of FTran601Class)()
        End Get
    End Property
    Public ReadOnly Property FTran602() As FTran602Class
        Get
            Return FTran602Class.GetInstance(Of FTran602Class)()
        End Get
    End Property
    Public ReadOnly Property FTran604() As FTran604Class
        Get
            Return FTran604Class.GetInstance(Of FTran604Class)()
        End Get
    End Property
    Public ReadOnly Property FTran605() As FTran605Class
        Get
            Return FTran605Class.GetInstance(Of FTran605Class)()
        End Get
    End Property
End Module
