<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FAcercaClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
		InitializeLine1()
	End Sub
    Private Sub ReleaseResources(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Closed
        Dispose(True)
    End Sub
    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
     Protected Overloads Overrides Sub Dispose(ByVal Disposing As Boolean)
        If Disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(Disposing)
    End Sub
    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer
    Friend WithEvents COBISViewResizer As COBISCorp.eCOBIS.Commons.COBISViewResizer
    Friend WithEvents COBISStyleProvider As COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider
    Public WithEvents COBISResourceProvider As COBISCorp.Framework.UI.Components.COBISResourceProvider
    Public ToolTip1 As System.Windows.Forms.ToolTip
    Public WithEvents picIcon As System.Windows.Forms.PictureBox
    Public WithEvents cmdSysInfo As System.Windows.Forms.Button
    Public WithEvents cmdOK As System.Windows.Forms.Button
    Private WithEvents _Line1_1 As System.Windows.Forms.Label
	Public WithEvents lblTexto As System.Windows.Forms.Label
	Public WithEvents lblCountry As System.Windows.Forms.Label
	Public WithEvents lblBank As System.Windows.Forms.Label
	Public WithEvents lblAutorizadoA As System.Windows.Forms.Label
	Public WithEvents lblDesarrolladoPor As System.Windows.Forms.Label
	Public WithEvents lblCopyright As System.Windows.Forms.Label
	Public WithEvents lblCobis As System.Windows.Forms.Label
	Public WithEvents lblTitle As System.Windows.Forms.Label
	Public WithEvents lblVersion As System.Windows.Forms.Label
	Public Line1(2) As System.Windows.Forms.Label
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FAcercaClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.picIcon = New System.Windows.Forms.PictureBox()
        Me.cmdSysInfo = New System.Windows.Forms.Button()
        Me.cmdOK = New System.Windows.Forms.Button()
        Me._Line1_1 = New System.Windows.Forms.Label()
        Me.lblTexto = New System.Windows.Forms.Label()
        Me.lblCountry = New System.Windows.Forms.Label()
        Me.lblBank = New System.Windows.Forms.Label()
        Me.lblAutorizadoA = New System.Windows.Forms.Label()
        Me.lblDesarrolladoPor = New System.Windows.Forms.Label()
        Me.lblCopyright = New System.Windows.Forms.Label()
        Me.lblCobis = New System.Windows.Forms.Label()
        Me.lblTitle = New System.Windows.Forms.Label()
        Me.lblVersion = New System.Windows.Forms.Label()
        CType(Me.picIcon, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'COBISViewResizer
        '
        Me.COBISViewResizer.AutoRelocateControls = False
        Me.COBISViewResizer.AutoResizeControls = False
        Me.COBISViewResizer.ContainerForm = Me
        Me.COBISViewResizer.EnabledResize = True
        '
        'picIcon
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.picIcon, False)
        Me.COBISViewResizer.SetAutoResize(Me.picIcon, False)
        Me.picIcon.BackColor = System.Drawing.Color.White
        Me.picIcon.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.picIcon, "Default")
        Me.picIcon.Cursor = System.Windows.Forms.Cursors.Default
        Me.picIcon.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.picIcon.Image = CType(resources.GetObject("picIcon.Image"), System.Drawing.Image)
        Me.picIcon.Location = New System.Drawing.Point(8, 55)
        Me.picIcon.Name = "picIcon"
        Me.picIcon.Size = New System.Drawing.Size(187, 95)
        Me.picIcon.TabIndex = 11
        Me.picIcon.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.picIcon, "")
        '
        'cmdSysInfo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdSysInfo, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdSysInfo, False)
        Me.cmdSysInfo.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdSysInfo, "Default")
        Me.cmdSysInfo.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdSysInfo.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdSysInfo.Location = New System.Drawing.Point(255, 311)
        Me.cmdSysInfo.Name = "cmdSysInfo"
        Me.cmdSysInfo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdSysInfo.Size = New System.Drawing.Size(123, 23)
        Me.cmdSysInfo.TabIndex = 10
        Me.cmdSysInfo.Text = "*Info. del Sistema..."
        Me.cmdSysInfo.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdSysInfo.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdSysInfo, "")
        '
        'cmdOK
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdOK, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdOK, False)
        Me.cmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdOK, "Default")
        Me.cmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdOK.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.cmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdOK.Location = New System.Drawing.Point(99, 311)
        Me.cmdOK.Name = "cmdOK"
        Me.cmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdOK.Size = New System.Drawing.Size(123, 23)
        Me.cmdOK.TabIndex = 9
        Me.cmdOK.Text = "* Aceptar"
        Me.cmdOK.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdOK.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdOK, "")
        '
        '_Line1_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Line1_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._Line1_1, False)
        Me._Line1_1.BackColor = System.Drawing.Color.Navy
        Me.COBISStyleProvider.SetControlStyle(Me._Line1_1, "Default")
        Me._Line1_1.Location = New System.Drawing.Point(5, 112)
        Me._Line1_1.Name = "_Line1_1"
        Me._Line1_1.Size = New System.Drawing.Size(302, 1)
        Me._Line1_1.TabIndex = 13
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Line1_1, "")
        '
        'lblTexto
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblTexto, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblTexto, False)
        Me.lblTexto.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblTexto, "Default")
        Me.lblTexto.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblTexto.ForeColor = System.Drawing.Color.Navy
        Me.lblTexto.Location = New System.Drawing.Point(22, 187)
        Me.lblTexto.Name = "lblTexto"
        Me.lblTexto.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblTexto.Size = New System.Drawing.Size(443, 20)
        Me.lblTexto.TabIndex = 8
        Me.lblTexto.Text = resources.GetString("lblTexto.Text")
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblTexto, "")
        '
        'lblCountry
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblCountry, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblCountry, False)
        Me.lblCountry.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblCountry, "Default")
        Me.lblCountry.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCountry.ForeColor = System.Drawing.Color.Navy
        Me.lblCountry.Location = New System.Drawing.Point(206, 160)
        Me.lblCountry.Name = "lblCountry"
        Me.lblCountry.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCountry.Size = New System.Drawing.Size(25, 20)
        Me.lblCountry.TabIndex = 7
        Me.lblCountry.Text = "Pais"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblCountry, "")
        '
        'lblBank
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblBank, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblBank, False)
        Me.lblBank.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblBank, "Default")
        Me.lblBank.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblBank.ForeColor = System.Drawing.Color.Navy
        Me.lblBank.Location = New System.Drawing.Point(206, 146)
        Me.lblBank.Name = "lblBank"
        Me.lblBank.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblBank.Size = New System.Drawing.Size(105, 20)
        Me.lblBank.TabIndex = 6
        Me.lblBank.Text = "Nombre del Banco"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblBank, "")
        '
        'lblAutorizadoA
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblAutorizadoA, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblAutorizadoA, False)
        Me.lblAutorizadoA.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblAutorizadoA, "Default")
        Me.lblAutorizadoA.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblAutorizadoA.ForeColor = System.Drawing.Color.Navy
        Me.lblAutorizadoA.Location = New System.Drawing.Point(206, 129)
        Me.lblAutorizadoA.Name = "lblAutorizadoA"
        Me.lblAutorizadoA.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblAutorizadoA.Size = New System.Drawing.Size(259, 20)
        Me.lblAutorizadoA.TabIndex = 5
        Me.lblAutorizadoA.Text = "El uso de este producto está autorizado a:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblAutorizadoA, "")
        '
        'lblDesarrolladoPor
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblDesarrolladoPor, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblDesarrolladoPor, False)
        Me.lblDesarrolladoPor.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblDesarrolladoPor, "Default")
        Me.lblDesarrolladoPor.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDesarrolladoPor.ForeColor = System.Drawing.Color.Navy
        Me.lblDesarrolladoPor.Location = New System.Drawing.Point(206, 95)
        Me.lblDesarrolladoPor.Name = "lblDesarrolladoPor"
        Me.lblDesarrolladoPor.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDesarrolladoPor.Size = New System.Drawing.Size(259, 20)
        Me.lblDesarrolladoPor.TabIndex = 4
        Me.lblDesarrolladoPor.Text = "Este Producto ha sido desarrollado por MACOSA S.A. - Ecuador"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblDesarrolladoPor, "")
        '
        'lblCopyright
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblCopyright, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblCopyright, False)
        Me.lblCopyright.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblCopyright, "Default")
        Me.lblCopyright.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCopyright.ForeColor = System.Drawing.Color.Navy
        Me.lblCopyright.Location = New System.Drawing.Point(206, 80)
        Me.lblCopyright.Name = "lblCopyright"
        Me.lblCopyright.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCopyright.Size = New System.Drawing.Size(199, 20)
        Me.lblCopyright.TabIndex = 3
        Me.lblCopyright.Text = "Copyright© 1997      MACOSA S.A."
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblCopyright, "")
        '
        'lblCobis
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblCobis, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblCobis, False)
        Me.lblCobis.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblCobis, "Default")
        Me.lblCobis.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCobis.ForeColor = System.Drawing.Color.Navy
        Me.lblCobis.Location = New System.Drawing.Point(50, 9)
        Me.lblCobis.Name = "lblCobis"
        Me.lblCobis.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCobis.Size = New System.Drawing.Size(383, 20)
        Me.lblCobis.TabIndex = 2
        Me.lblCobis.Text = "Cooperative, Open Banking Information System"
        Me.lblCobis.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblCobis, "")
        '
        'lblTitle
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblTitle, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblTitle, False)
        Me.lblTitle.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblTitle, "Default")
        Me.lblTitle.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblTitle.ForeColor = System.Drawing.Color.Navy
        Me.lblTitle.Location = New System.Drawing.Point(206, 38)
        Me.lblTitle.Name = "lblTitle"
        Me.lblTitle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblTitle.Size = New System.Drawing.Size(259, 20)
        Me.lblTitle.TabIndex = 0
        Me.lblTitle.Text = "Nombre del Módulo"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblTitle, "")
        '
        'lblVersion
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblVersion, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblVersion, False)
        Me.lblVersion.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblVersion, "Default")
        Me.lblVersion.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblVersion.ForeColor = System.Drawing.Color.Navy
        Me.lblVersion.Location = New System.Drawing.Point(206, 54)
        Me.lblVersion.Name = "lblVersion"
        Me.lblVersion.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblVersion.Size = New System.Drawing.Size(259, 20)
        Me.lblVersion.TabIndex = 1
        Me.lblVersion.Text = "Versión"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblVersion, "")
        '
        'FAcercaClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.BackgroundImage = CType(resources.GetObject("$this.BackgroundImage"), System.Drawing.Image)
        Me.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Location = New System.Drawing.Point(134, 99)
        Me.Name = "FAcercaClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(483, 346)
        Me.Text = "Acerca de"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.picIcon, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
	Sub InitializeLine1()
		Me.Line1(1) = _Line1_1
	End Sub
#End Region 
End Class


