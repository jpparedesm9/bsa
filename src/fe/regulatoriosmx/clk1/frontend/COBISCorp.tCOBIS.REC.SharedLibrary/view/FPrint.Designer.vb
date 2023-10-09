<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FPrintClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
		InitializeoptOrientacion()
		Initializecmdboton()
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
	Private WithEvents _optOrientacion_1 As System.Windows.Forms.RadioButton
	Private WithEvents _optOrientacion_0 As System.Windows.Forms.RadioButton
	Public WithEvents cmbPrinters As System.Windows.Forms.ComboBox
	Public WithEvents Label1 As System.Windows.Forms.Label
	Public WithEvents lblPrinters As System.Windows.Forms.Label
	Public WithEvents fraPrinters As Infragistics.Win.Misc.UltraGroupBox
	Private WithEvents _cmdboton_1 As System.Windows.Forms.Button
	Private WithEvents _cmdboton_0 As System.Windows.Forms.Button
	Public cmdboton(1) As System.Windows.Forms.Button
	Public optOrientacion(1) As System.Windows.Forms.RadioButton
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FPrintClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.fraPrinters = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optOrientacion_1 = New System.Windows.Forms.RadioButton()
        Me._optOrientacion_0 = New System.Windows.Forms.RadioButton()
        Me.cmbPrinters = New System.Windows.Forms.ComboBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.lblPrinters = New System.Windows.Forms.Label()
        Me._cmdboton_1 = New System.Windows.Forms.Button()
        Me._cmdboton_0 = New System.Windows.Forms.Button()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBAceptar = New System.Windows.Forms.ToolStripButton()
        Me.TSBCancelar = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.fraPrinters, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.fraPrinters.SuspendLayout()
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
        'fraPrinters
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.fraPrinters, False)
        Me.COBISViewResizer.SetAutoResize(Me.fraPrinters, False)
        Me.fraPrinters.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.fraPrinters.Controls.Add(Me._optOrientacion_1)
        Me.fraPrinters.Controls.Add(Me._optOrientacion_0)
        Me.fraPrinters.Controls.Add(Me.cmbPrinters)
        Me.fraPrinters.Controls.Add(Me.Label1)
        Me.fraPrinters.Controls.Add(Me.lblPrinters)
        Me.COBISStyleProvider.SetControlStyle(Me.fraPrinters, "Default")
        Me.fraPrinters.ForeColor = System.Drawing.Color.Navy
        Me.fraPrinters.Location = New System.Drawing.Point(10, 10)
        Me.fraPrinters.Name = "fraPrinters"
        Me.COBISResourceProvider.SetResourceID(Me.fraPrinters, "500256")
        Me.fraPrinters.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fraPrinters.Size = New System.Drawing.Size(297, 89)
        Me.fraPrinters.TabIndex = 1
        Me.fraPrinters.Text = "*Lista de Impresoras Disponibles: "
        Me.fraPrinters.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.fraPrinters, "")
        '
        '_optOrientacion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optOrientacion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optOrientacion_1, False)
        Me._optOrientacion_1.BackColor = System.Drawing.Color.Transparent
        Me._optOrientacion_1.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optOrientacion_1, "Default")
        Me._optOrientacion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optOrientacion_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._optOrientacion_1.Location = New System.Drawing.Point(216, 56)
        Me._optOrientacion_1.Name = "_optOrientacion_1"
        Me.COBISResourceProvider.SetResourceID(Me._optOrientacion_1, "1012")
        Me._optOrientacion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optOrientacion_1.Size = New System.Drawing.Size(83, 25)
        Me._optOrientacion_1.TabIndex = 6
        Me._optOrientacion_1.TabStop = True
        Me._optOrientacion_1.Text = "*Horizontal"
        Me._optOrientacion_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optOrientacion_1, "")
        '
        '_optOrientacion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optOrientacion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optOrientacion_0, False)
        Me._optOrientacion_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optOrientacion_0, "Default")
        Me._optOrientacion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optOrientacion_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._optOrientacion_0.Location = New System.Drawing.Point(152, 56)
        Me._optOrientacion_0.Name = "_optOrientacion_0"
        Me.COBISResourceProvider.SetResourceID(Me._optOrientacion_0, "1011")
        Me._optOrientacion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optOrientacion_0.Size = New System.Drawing.Size(65, 25)
        Me._optOrientacion_0.TabIndex = 5
        Me._optOrientacion_0.TabStop = True
        Me._optOrientacion_0.Text = "*Vertical"
        Me._optOrientacion_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optOrientacion_0, "")
        '
        'cmbPrinters
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmbPrinters, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmbPrinters, False)
        Me.cmbPrinters.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.cmbPrinters, "Default")
        Me.cmbPrinters.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbPrinters.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbPrinters.Location = New System.Drawing.Point(72, 32)
        Me.cmbPrinters.Name = "cmbPrinters"
        Me.cmbPrinters.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbPrinters.Size = New System.Drawing.Size(217, 21)
        Me.cmbPrinters.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmbPrinters, "")
        '
        'Label1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label1, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label1, False)
        Me.Label1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label1, "Default")
        Me.Label1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label1.ForeColor = System.Drawing.Color.Navy
        Me.Label1.Location = New System.Drawing.Point(80, 56)
        Me.Label1.Name = "Label1"
        Me.COBISResourceProvider.SetResourceID(Me.Label1, "500257")
        Me.Label1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label1.Size = New System.Drawing.Size(65, 20)
        Me.Label1.TabIndex = 7
        Me.Label1.Text = "*Orientación:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label1, "")
        '
        'lblPrinters
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblPrinters, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblPrinters, False)
        Me.lblPrinters.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblPrinters, "Default")
        Me.lblPrinters.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblPrinters.ForeColor = System.Drawing.Color.Navy
        Me.lblPrinters.Location = New System.Drawing.Point(10, 32)
        Me.lblPrinters.Name = "lblPrinters"
        Me.COBISResourceProvider.SetResourceID(Me.lblPrinters, "500258")
        Me.lblPrinters.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblPrinters.Size = New System.Drawing.Size(60, 20)
        Me.lblPrinters.TabIndex = 2
        Me.lblPrinters.Text = "*Impresora:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblPrinters, "")
        '
        '_cmdboton_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdboton_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdboton_1, False)
        Me._cmdboton_1.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdboton_1, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdboton_1, True)
        Me._cmdboton_1.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdboton_1, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdboton_1, Nothing)
        Me._cmdboton_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdboton_1.Location = New System.Drawing.Point(-312, 40)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdboton_1, System.Drawing.Color.Silver)
        Me._cmdboton_1.Name = "_cmdboton_1"
        Me._cmdboton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdboton_1.Size = New System.Drawing.Size(100, 23)
        Me.commandButtonHelper1.SetStyle(Me._cmdboton_1, 1)
        Me._cmdboton_1.TabIndex = 3
        Me._cmdboton_1.Text = "&Cancelar"
        Me._cmdboton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdboton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdboton_1, "")
        '
        '_cmdboton_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdboton_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdboton_0, False)
        Me._cmdboton_0.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdboton_0, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdboton_0, True)
        Me._cmdboton_0.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdboton_0, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdboton_0, Nothing)
        Me._cmdboton_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdboton_0.Location = New System.Drawing.Point(-312, 16)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdboton_0, System.Drawing.Color.Silver)
        Me._cmdboton_0.Name = "_cmdboton_0"
        Me._cmdboton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdboton_0.Size = New System.Drawing.Size(100, 23)
        Me.commandButtonHelper1.SetStyle(Me._cmdboton_0, 1)
        Me._cmdboton_0.TabIndex = 4
        Me._cmdboton_0.Text = "&Aceptar"
        Me._cmdboton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdboton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdboton_0, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.fraPrinters)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(317, 110)
        Me.PFormas.TabIndex = 5
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBAceptar, Me.TSBCancelar})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(341, 25)
        Me.TSBotones.TabIndex = 6
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBAceptar
        '
        Me.TSBAceptar.Image = CType(resources.GetObject("TSBAceptar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBAceptar, "2011")
        Me.TSBAceptar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBAceptar.Name = "TSBAceptar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBAceptar, "2011")
        Me.TSBAceptar.Size = New System.Drawing.Size(73, 22)
        Me.TSBAceptar.Text = "*&Aceptar"
        '
        'TSBCancelar
        '
        Me.TSBCancelar.Image = CType(resources.GetObject("TSBCancelar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBCancelar, "2023")
        Me.TSBCancelar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBCancelar.Name = "TSBCancelar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBCancelar, "2012")
        Me.TSBCancelar.Size = New System.Drawing.Size(78, 22)
        Me.TSBCancelar.Text = "*&Cancelar"
        '
        'FPrintClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me._cmdboton_1)
        Me.Controls.Add(Me._cmdboton_0)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Location = New System.Drawing.Point(4, 23)
        Me.Name = "FPrintClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(341, 157)
        Me.Text = "Seleccion de Impresora"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.fraPrinters, System.ComponentModel.ISupportInitialize).EndInit()
        Me.fraPrinters.ResumeLayout(False)
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializeoptOrientacion()
        Me.optOrientacion(1) = _optOrientacion_1
        Me.optOrientacion(0) = _optOrientacion_0
    End Sub
    Sub Initializecmdboton()
        Me.cmdboton(1) = _cmdboton_1
        Me.cmdboton(0) = _cmdboton_0
    End Sub
    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBAceptar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBCancelar As System.Windows.Forms.ToolStripButton
#End Region 
End Class


