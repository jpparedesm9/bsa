<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FClaveClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
		InitializetxtCampo()
		InitializelblDescripcion()
		InitializecmdBoton()
		InitializeLabel1()
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
	Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
	Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
	Private WithEvents _txtCampo_1 As System.Windows.Forms.TextBox
	Private WithEvents _txtCampo_0 As System.Windows.Forms.TextBox
	Private WithEvents _Label1_2 As System.Windows.Forms.Label
	Private WithEvents _Label1_1 As System.Windows.Forms.Label
	Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
	Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
	Private WithEvents _Label1_0 As System.Windows.Forms.Label
	Public Label1(2) As System.Windows.Forms.Label
	Public cmdBoton(1) As System.Windows.Forms.Button
	Public lblDescripcion(1) As System.Windows.Forms.Label
	Public txtCampo(1) As System.Windows.Forms.TextBox
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FClaveClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._txtCampo_1 = New System.Windows.Forms.TextBox()
        Me._txtCampo_0 = New System.Windows.Forms.TextBox()
        Me._Label1_2 = New System.Windows.Forms.Label()
        Me._Label1_1 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._Label1_0 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        Me.TSBotones.SuspendLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'COBISViewResizer
        '
        Me.COBISViewResizer.AutoRelocateControls = False
        Me.COBISViewResizer.AutoResizeControls = False
        Me.COBISViewResizer.ContainerForm = Me
        Me.COBISViewResizer.EnabledResize = True
        '
        '_cmdBoton_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_0, False)
        Me._cmdBoton_0.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_0, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_0, True)
        Me._cmdBoton_0.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_0, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_0, Nothing)
        Me._cmdBoton_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_0.Location = New System.Drawing.Point(-406, 113)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 8
        Me._cmdBoton_0.Text = "*&Salir"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
        '
        '_cmdBoton_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_1, False)
        Me._cmdBoton_1.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_1, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_1, True)
        Me._cmdBoton_1.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_1, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_1, Nothing)
        Me._cmdBoton_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_1.Location = New System.Drawing.Point(-406, 62)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 7
        Me._cmdBoton_1.Text = "*&Transmitir"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
        '
        '_txtCampo_1
        '
        Me._txtCampo_1.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_1, False)
        Me._txtCampo_1.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_1, "Default")
        Me._txtCampo_1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_1.ImeMode = System.Windows.Forms.ImeMode.Disable
        Me._txtCampo_1.Location = New System.Drawing.Point(197, 77)
        Me._txtCampo_1.MaxLength = 0
        Me._txtCampo_1.Name = "_txtCampo_1"
        Me._txtCampo_1.PasswordChar = Global.Microsoft.VisualBasic.ChrW(187)
        Me._txtCampo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_1.Size = New System.Drawing.Size(180, 20)
        Me._txtCampo_1.TabIndex = 6
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_1, "")
        '
        '_txtCampo_0
        '
        Me._txtCampo_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_0, False)
        Me._txtCampo_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_0, "Default")
        Me._txtCampo_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_0.ImeMode = System.Windows.Forms.ImeMode.Disable
        Me._txtCampo_0.Location = New System.Drawing.Point(197, 54)
        Me._txtCampo_0.MaxLength = 0
        Me._txtCampo_0.Name = "_txtCampo_0"
        Me._txtCampo_0.PasswordChar = Global.Microsoft.VisualBasic.ChrW(187)
        Me._txtCampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_0.Size = New System.Drawing.Size(180, 20)
        Me._txtCampo_0.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_0, "")
        '
        '_Label1_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Label1_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._Label1_2, False)
        Me._Label1_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Label1_2, "Default")
        Me._Label1_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label1_2.ForeColor = System.Drawing.Color.Navy
        Me._Label1_2.Location = New System.Drawing.Point(63, 77)
        Me._Label1_2.Name = "_Label1_2"
        Me.COBISResourceProvider.SetResourceID(Me._Label1_2, "2512")
        Me._Label1_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label1_2.Size = New System.Drawing.Size(137, 20)
        Me._Label1_2.TabIndex = 1
        Me._Label1_2.Text = "*Verificación de Clave:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Label1_2, "")
        '
        '_Label1_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Label1_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._Label1_1, False)
        Me._Label1_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Label1_1, "Default")
        Me._Label1_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label1_1.ForeColor = System.Drawing.Color.Navy
        Me._Label1_1.Location = New System.Drawing.Point(62, 54)
        Me._Label1_1.Name = "_Label1_1"
        Me.COBISResourceProvider.SetResourceID(Me._Label1_1, "500944")
        Me._Label1_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label1_1.Size = New System.Drawing.Size(47, 20)
        Me._Label1_1.TabIndex = 5
        Me._Label1_1.Text = "*Clave:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Label1_1, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(82, 30)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(295, 20)
        Me._lblDescripcion_1.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.Location = New System.Drawing.Point(28, 30)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(53, 20)
        Me._lblDescripcion_0.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        '_Label1_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Label1_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._Label1_0, False)
        Me._Label1_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Label1_0, "Default")
        Me._Label1_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label1_0.ForeColor = System.Drawing.Color.Navy
        Me._Label1_0.Location = New System.Drawing.Point(10, 10)
        Me._Label1_0.Name = "_Label1_0"
        Me.COBISResourceProvider.SetResourceID(Me._Label1_0, "2511")
        Me._Label1_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label1_0.Size = New System.Drawing.Size(189, 20)
        Me._Label1_0.TabIndex = 0
        Me._Label1_0.Text = "*Funcionario (Supervisor):"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Label1_0, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me._Label1_0)
        Me.PFormas.Controls.Add(Me._cmdBoton_0)
        Me.PFormas.Controls.Add(Me._lblDescripcion_0)
        Me.PFormas.Controls.Add(Me._cmdBoton_1)
        Me.PFormas.Controls.Add(Me._lblDescripcion_1)
        Me.PFormas.Controls.Add(Me._txtCampo_1)
        Me.PFormas.Controls.Add(Me._Label1_1)
        Me.PFormas.Controls.Add(Me._txtCampo_0)
        Me.PFormas.Controls.Add(Me._Label1_2)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(387, 107)
        Me.PFormas.TabIndex = 9
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBTransmitir, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(407, 25)
        Me.TSBotones.TabIndex = 10
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.ForeColor = System.Drawing.Color.Navy
        Me.TSBTransmitir.Image = CType(resources.GetObject("TSBTransmitir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBTransmitir.Name = "TSBTransmitir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.Size = New System.Drawing.Size(86, 22)
        Me.TSBTransmitir.Text = "*&Transmitir"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Navy
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1006")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'FClaveClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Location = New System.Drawing.Point(102, 226)
        Me.Name = "FClaveClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(407, 153)
        Me.Text = "Clave de Supervisor"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializetxtCampo()
        Me.txtCampo(1) = _txtCampo_1
        Me.txtCampo(0) = _txtCampo_0
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(0) = _lblDescripcion_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(1) = _cmdBoton_1
    End Sub
    Sub InitializeLabel1()
        Me.Label1(2) = _Label1_2
        Me.Label1(1) = _Label1_1
        Me.Label1(0) = _Label1_0
    End Sub
    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
#End Region 
End Class


