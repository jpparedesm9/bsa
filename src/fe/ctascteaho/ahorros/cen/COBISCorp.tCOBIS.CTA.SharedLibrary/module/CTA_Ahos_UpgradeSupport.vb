Public Module UpgradeSupport
    Private _DAO_DBEngine_definst As DAO.DBEngine = Nothing

    Public ReadOnly Property DAO_DBEngine_definst() As DAO.DBEngine
        Get
            If _DAO_DBEngine_definst Is Nothing Then
                _DAO_DBEngine_definst = New DAO.DBEngine
            End If
            Return _DAO_DBEngine_definst
        End Get
    End Property
End Module


