<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FREEXPEDIRClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
		InitializelblConfNuevaTarjeta()
		'This form is an MDI child.
		'This code simulates the Compatibility.VB6 
		' functionality of automatically
		' loading and showing an MDI
		' child's parent.
		'The MDI form in the Compatibility.VB6 project had its
		'AutoShowChildren property set to True
		'To simulate the Compatibility.VB6 behavior, we need to
		'automatically Show the form whenever it
		'is loaded.  If you do not want this behavior
		'then delete the following line of code
		'UPGRADE_TODO: (2018) Remove the next line of code to stop form from automatically showing. More Information: http://www.vbtonet.com/ewis/ewi2018.aspx
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
	Public WithEvents txtTarjetaDebito As System.Windows.Forms.TextBox
	Public WithEvents txtConfirmaTarjDeb As System.Windows.Forms.TextBox
	Public WithEvents cmdOk As System.Windows.Forms.Button
	Public WithEvents cmdSalir As System.Windows.Forms.Button
	Public WithEvents lblNuevaTarjeta As System.Windows.Forms.Label
	Private WithEvents _lblConfNuevaTarjeta_0 As System.Windows.Forms.Label
	Public lblConfNuevaTarjeta(0) As System.Windows.Forms.Label
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FREEXPEDIRClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.txtTarjetaDebito = New System.Windows.Forms.TextBox()
        Me.txtConfirmaTarjDeb = New System.Windows.Forms.TextBox()
        Me.cmdOk = New System.Windows.Forms.Button()
        Me.cmdSalir = New System.Windows.Forms.Button()
        Me.lblNuevaTarjeta = New System.Windows.Forms.Label()
        Me._lblConfNuevaTarjeta_0 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBOk = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        Me.TSBBotones.SuspendLayout()
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
        'txtTarjetaDebito
        '
        Me.txtTarjetaDebito.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtTarjetaDebito, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtTarjetaDebito, False)
        Me.txtTarjetaDebito.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtTarjetaDebito, "Default")
        Me.txtTarjetaDebito.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtTarjetaDebito.Location = New System.Drawing.Point(171, 10)
        Me.txtTarjetaDebito.MaxLength = 19
        Me.txtTarjetaDebito.Name = "txtTarjetaDebito"
        Me.txtTarjetaDebito.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtTarjetaDebito.Size = New System.Drawing.Size(148, 20)
        Me.txtTarjetaDebito.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtTarjetaDebito, "")
        '
        'txtConfirmaTarjDeb
        '
        Me.txtConfirmaTarjDeb.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtConfirmaTarjDeb, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtConfirmaTarjDeb, False)
        Me.txtConfirmaTarjDeb.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtConfirmaTarjDeb, "Default")
        Me.txtConfirmaTarjDeb.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtConfirmaTarjDeb.Location = New System.Drawing.Point(171, 33)
        Me.txtConfirmaTarjDeb.MaxLength = 19
        Me.txtConfirmaTarjDeb.Name = "txtConfirmaTarjDeb"
        Me.txtConfirmaTarjDeb.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtConfirmaTarjDeb.Size = New System.Drawing.Size(148, 20)
        Me.txtConfirmaTarjDeb.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtConfirmaTarjDeb, "")
        '
        'cmdOk
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdOk, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdOk, False)
        Me.cmdOk.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdOk, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdOk, True)
        Me.cmdOk.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdOk, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdOk, Nothing)
        Me.cmdOk.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdOk.Location = New System.Drawing.Point(92, 87)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdOk, System.Drawing.Color.Silver)
        Me.cmdOk.Name = "cmdOk"
        Me.cmdOk.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdOk.Size = New System.Drawing.Size(58, 33)
        Me.commandButtonHelper1.SetStyle(Me.cmdOk, 1)
        Me.cmdOk.TabIndex = 2
        Me.cmdOk.Text = "&OK"
        Me.cmdOk.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdOk.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdOk, "")
        '
        'cmdSalir
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdSalir, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdSalir, False)
        Me.cmdSalir.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdSalir, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdSalir, True)
        Me.cmdSalir.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdSalir, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdSalir, Nothing)
        Me.cmdSalir.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdSalir.Location = New System.Drawing.Point(172, 87)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdSalir, System.Drawing.Color.Silver)
        Me.cmdSalir.Name = "cmdSalir"
        Me.cmdSalir.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdSalir.Size = New System.Drawing.Size(58, 33)
        Me.commandButtonHelper1.SetStyle(Me.cmdSalir, 1)
        Me.cmdSalir.TabIndex = 5
        Me.cmdSalir.Text = "&Salir"
        Me.cmdSalir.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdSalir.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdSalir, "")
        '
        'lblNuevaTarjeta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblNuevaTarjeta, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblNuevaTarjeta, False)
        Me.lblNuevaTarjeta.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblNuevaTarjeta, "Default")
        Me.lblNuevaTarjeta.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblNuevaTarjeta.ForeColor = System.Drawing.Color.Navy
        Me.lblNuevaTarjeta.Location = New System.Drawing.Point(10, 10)
        Me.lblNuevaTarjeta.Name = "lblNuevaTarjeta"
        Me.COBISResourceProvider.SetResourceID(Me.lblNuevaTarjeta, "2201")
        Me.lblNuevaTarjeta.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblNuevaTarjeta.Size = New System.Drawing.Size(114, 20)
        Me.lblNuevaTarjeta.TabIndex = 4
        Me.lblNuevaTarjeta.Text = "*Nro. Tarjeta Debito:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblNuevaTarjeta, "")
        '
        '_lblConfNuevaTarjeta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblConfNuevaTarjeta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblConfNuevaTarjeta_0, False)
        Me._lblConfNuevaTarjeta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblConfNuevaTarjeta_0, "Default")
        Me._lblConfNuevaTarjeta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblConfNuevaTarjeta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblConfNuevaTarjeta_0.Location = New System.Drawing.Point(10, 33)
        Me._lblConfNuevaTarjeta_0.Name = "_lblConfNuevaTarjeta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblConfNuevaTarjeta_0, "2202")
        Me._lblConfNuevaTarjeta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblConfNuevaTarjeta_0.Size = New System.Drawing.Size(155, 20)
        Me._lblConfNuevaTarjeta_0.TabIndex = 3
        Me._lblConfNuevaTarjeta_0.Text = "*Confirm. Nro. Tarjeta Debito:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblConfNuevaTarjeta_0, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me._lblConfNuevaTarjeta_0)
        Me.PFormas.Controls.Add(Me.txtTarjetaDebito)
        Me.PFormas.Controls.Add(Me.lblNuevaTarjeta)
        Me.PFormas.Controls.Add(Me.txtConfirmaTarjDeb)
        Me.PFormas.Controls.Add(Me.cmdSalir)
        Me.PFormas.Controls.Add(Me.cmdOk)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(324, 61)
        Me.PFormas.TabIndex = 6
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'TSBBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBBotones, "Default")
        Me.TSBBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBOk, Me.TSBSalir})
        Me.TSBBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBBotones.Name = "TSBBotones"
        Me.TSBBotones.Size = New System.Drawing.Size(344, 25)
        Me.TSBBotones.TabIndex = 7
        Me.TSBBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBBotones, "")
        '
        'TSBOk
        '
        Me.TSBOk.Image = CType(resources.GetObject("TSBOk.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBOk, "2062")
        Me.TSBOk.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBOk.Name = "TSBOk"
        Me.COBISResourceProvider.SetResourceID(Me.TSBOk, "2041")
        Me.TSBOk.Size = New System.Drawing.Size(48, 22)
        Me.TSBOk.Text = "*&OK"
        '
        'TSBSalir
        '
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'FREEXPEDIRClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBBotones)
        Me.Controls.Add(Me.PFormas)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Location = New System.Drawing.Point(4, 30)
        Me.Name = "FREEXPEDIRClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(344, 117)
        Me.Text = "Ingrese Número Nueva Tarjeta…"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        Me.TSBBotones.ResumeLayout(False)
        Me.TSBBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializelblConfNuevaTarjeta()
        Me.lblConfNuevaTarjeta(0) = _lblConfNuevaTarjeta_0
    End Sub
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBOk As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
#End Region 
End Class


