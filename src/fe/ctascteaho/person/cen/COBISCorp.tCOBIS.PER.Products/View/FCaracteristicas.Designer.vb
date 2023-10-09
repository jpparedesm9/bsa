<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FCaracteristicasClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    'UserControl overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    Public Sub New()
        MyBase.New()

        InitializeComponent()
        InitializetxtCampo()
        InitializeoptBoton()

    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer
    Public txtCampo(4) As System.Windows.Forms.TextBox
    Public optBoton(2) As System.Windows.Forms.RadioButton

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FCaracteristicasClass))
        Me.frmEstado = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optBoton_0 = New System.Windows.Forms.RadioButton()
        Me._optBoton_1 = New System.Windows.Forms.RadioButton()
        Me.ToolStrip1 = New System.Windows.Forms.ToolStrip()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBLlimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me.Label1 = New System.Windows.Forms.Label()
        Me._txtCampo_1 = New System.Windows.Forms.TextBox()
        Me._lblDescripcion_3 = New System.Windows.Forms.Label()
        Me.UltraGroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        Me._txtCampo_4 = New System.Windows.Forms.TextBox()
        Me.chkproducto = New System.Windows.Forms.CheckBox()
        Me._lblDescripcion_6 = New System.Windows.Forms.Label()
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        CType(Me.frmEstado, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.frmEstado.SuspendLayout()
        Me.ToolStrip1.SuspendLayout()
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox1.SuspendLayout()
        Me.GroupBox1.SuspendLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'frmEstado
        '
        Me.frmEstado.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.frmEstado.Controls.Add(Me._optBoton_0)
        Me.frmEstado.Controls.Add(Me._optBoton_1)
        Me.COBISStyleProvider.SetControlStyle(Me.frmEstado, "Default")
        Me.frmEstado.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.frmEstado.ForeColor = System.Drawing.Color.Navy
        Me.frmEstado.Location = New System.Drawing.Point(174, 19)
        Me.frmEstado.Name = "frmEstado"
        Me.frmEstado.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.frmEstado.Size = New System.Drawing.Size(184, 29)
        Me.frmEstado.TabIndex = 0
        Me.frmEstado.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        '
        '_optBoton_0
        '
        Me._optBoton_0.BackColor = System.Drawing.Color.Transparent
        Me._optBoton_0.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optBoton_0, "Default")
        Me._optBoton_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optBoton_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optBoton_0.ForeColor = System.Drawing.Color.Navy
        Me._optBoton_0.Location = New System.Drawing.Point(8, 3)
        Me._optBoton_0.Name = "_optBoton_0"
        Me.COBISResourceProvider.SetResourceID(Me._optBoton_0, "1724")
        Me._optBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optBoton_0.Size = New System.Drawing.Size(73, 20)
        Me._optBoton_0.TabIndex = 1
        Me._optBoton_0.TabStop = True
        Me._optBoton_0.Text = "*Si"
        Me._optBoton_0.UseVisualStyleBackColor = True
        '
        '_optBoton_1
        '
        Me._optBoton_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optBoton_1, "Default")
        Me._optBoton_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optBoton_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optBoton_1.ForeColor = System.Drawing.Color.Navy
        Me._optBoton_1.Location = New System.Drawing.Point(93, 3)
        Me._optBoton_1.Name = "_optBoton_1"
        Me.COBISResourceProvider.SetResourceID(Me._optBoton_1, "1500")
        Me._optBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optBoton_1.Size = New System.Drawing.Size(95, 20)
        Me._optBoton_1.TabIndex = 2
        Me._optBoton_1.TabStop = True
        Me._optBoton_1.Text = "*No"
        Me._optBoton_1.UseVisualStyleBackColor = True
        '
        'ToolStrip1
        '
        Me.COBISStyleProvider.SetControlStyle(Me.ToolStrip1, "Default")
        Me.ToolStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBTransmitir, Me.TSBLlimpiar, Me.TSBSalir})
        Me.ToolStrip1.Location = New System.Drawing.Point(0, 0)
        Me.ToolStrip1.Name = "ToolStrip1"
        Me.ToolStrip1.Size = New System.Drawing.Size(689, 25)
        Me.ToolStrip1.TabIndex = 34
        Me.ToolStrip1.Text = "ToolStrip1"
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.Image = CType(resources.GetObject("TSBTransmitir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBTransmitir, "30007")
        Me.TSBTransmitir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBTransmitir.Name = "TSBTransmitir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBTransmitir, "1009")
        Me.TSBTransmitir.Size = New System.Drawing.Size(86, 22)
        Me.TSBTransmitir.Text = "*&Transmitir"
        '
        'TSBLlimpiar
        '
        Me.TSBLlimpiar.Image = CType(resources.GetObject("TSBLlimpiar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBLlimpiar, "30003")
        Me.TSBLlimpiar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBLlimpiar.Name = "TSBLlimpiar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBLlimpiar, "1006")
        Me.TSBLlimpiar.Size = New System.Drawing.Size(72, 22)
        Me.TSBLlimpiar.Text = "*&Limpiar"
        '
        'TSBSalir
        '
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "30008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1007")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        '_lblEtiqueta_2
        '
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(5, 28)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "1946")
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(115, 20)
        Me._lblEtiqueta_2.TabIndex = 34
        Me._lblEtiqueta_2.Text = "*Provisiona Intereses:"
        '
        'Label1
        '
        Me.Label1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label1, "Default")
        Me.Label1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label1.ForeColor = System.Drawing.Color.Navy
        Me.Label1.Location = New System.Drawing.Point(8, 58)
        Me.Label1.Name = "Label1"
        Me.COBISResourceProvider.SetResourceID(Me.Label1, "502038")
        Me.Label1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label1.Size = New System.Drawing.Size(133, 20)
        Me.Label1.TabIndex = 36
        Me.Label1.Text = "*Rango de Edad:"
        '
        '_txtCampo_1
        '
        Me._txtCampo_1.AcceptsReturn = True
        Me._txtCampo_1.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_1, "Default")
        Me._txtCampo_1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_1.Location = New System.Drawing.Point(180, 58)
        Me._txtCampo_1.MaxLength = 5
        Me._txtCampo_1.Name = "_txtCampo_1"
        Me._txtCampo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_1.Size = New System.Drawing.Size(45, 20)
        Me._txtCampo_1.TabIndex = 3
        '
        '_lblDescripcion_3
        '
        Me._lblDescripcion_3.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_3, "Default")
        Me._lblDescripcion_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_3.Location = New System.Drawing.Point(227, 58)
        Me._lblDescripcion_3.Name = "_lblDescripcion_3"
        Me._lblDescripcion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_3.Size = New System.Drawing.Size(407, 20)
        Me._lblDescripcion_3.TabIndex = 55
        '
        'UltraGroupBox1
        '
        Me.UltraGroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox1.Controls.Add(Me.GroupBox1)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox1, "Default")
        Me.UltraGroupBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.UltraGroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox1.Location = New System.Drawing.Point(5, 27)
        Me.UltraGroupBox1.Name = "UltraGroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.UltraGroupBox1, "2469")
        Me.UltraGroupBox1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.UltraGroupBox1.Size = New System.Drawing.Size(681, 297)
        Me.UltraGroupBox1.TabIndex = 34
        Me.UltraGroupBox1.Text = "*Características Adicionales"
        Me.UltraGroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        '
        'GroupBox1
        '
        Me.GroupBox1.BackColor = System.Drawing.Color.Transparent
        Me.GroupBox1.Controls.Add(Me.frmEstado)
        Me.GroupBox1.Controls.Add(Me._txtCampo_4)
        Me.GroupBox1.Controls.Add(Me.Label1)
        Me.GroupBox1.Controls.Add(Me.chkproducto)
        Me.GroupBox1.Controls.Add(Me._lblDescripcion_3)
        Me.GroupBox1.Controls.Add(Me._lblDescripcion_6)
        Me.GroupBox1.Controls.Add(Me._lblEtiqueta_2)
        Me.GroupBox1.Controls.Add(Me._txtCampo_1)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.Location = New System.Drawing.Point(9, 87)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(655, 126)
        Me.GroupBox1.TabIndex = 60
        Me.GroupBox1.TabStop = False
        '
        '_txtCampo_4
        '
        Me._txtCampo_4.AcceptsReturn = True
        Me._txtCampo_4.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_4, "Default")
        Me._txtCampo_4.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_4.Location = New System.Drawing.Point(180, 84)
        Me._txtCampo_4.MaxLength = 5
        Me._txtCampo_4.Name = "_txtCampo_4"
        Me._txtCampo_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_4.Size = New System.Drawing.Size(45, 20)
        Me._txtCampo_4.TabIndex = 5
        '
        'chkproducto
        '
        Me.chkproducto.AutoSize = True
        Me.chkproducto.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.chkproducto, "Default")
        Me.chkproducto.ForeColor = System.Drawing.Color.Black
        Me.chkproducto.Location = New System.Drawing.Point(11, 86)
        Me.chkproducto.Name = "chkproducto"
        Me.COBISResourceProvider.SetResourceID(Me.chkproducto, "1947")
        Me.chkproducto.Size = New System.Drawing.Size(161, 17)
        Me.chkproducto.TabIndex = 4
        Me.chkproducto.Text = "*Depende de Otro Producto:"
        Me.chkproducto.UseVisualStyleBackColor = False
        '
        '_lblDescripcion_6
        '
        Me._lblDescripcion_6.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_6.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_6, "Default")
        Me._lblDescripcion_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_6.Location = New System.Drawing.Point(227, 84)
        Me._lblDescripcion_6.Name = "_lblDescripcion_6"
        Me._lblDescripcion_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_6.Size = New System.Drawing.Size(407, 20)
        Me._lblDescripcion_6.TabIndex = 59
        '
        'FCaracteristicasClass
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.ButtonHighlight
        Me.Controls.Add(Me.UltraGroupBox1)
        Me.Controls.Add(Me.ToolStrip1)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Name = "FCaracteristicasClass"
        Me.COBISResourceProvider.SetResourceID(Me, "2469")
        Me.Size = New System.Drawing.Size(689, 329)
        Me.Text = "Caracteristicas Adicionales"
        CType(Me.frmEstado, System.ComponentModel.ISupportInitialize).EndInit()
        Me.frmEstado.ResumeLayout(False)
        Me.ToolStrip1.ResumeLayout(False)
        Me.ToolStrip1.PerformLayout()
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox1.ResumeLayout(False)
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Sub InitializetxtCampo()
        Me.txtCampo(1) = _txtCampo_1
        Me.txtCampo(4) = _txtCampo_4


    End Sub

    Sub InitializeoptBoton()
        Me.optBoton(1) = _optBoton_0
        Me.optBoton(2) = _optBoton_1
    End Sub
    Public WithEvents frmEstado As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _optBoton_0 As System.Windows.Forms.RadioButton
    Private WithEvents _optBoton_1 As System.Windows.Forms.RadioButton
    Friend WithEvents ToolStrip1 As System.Windows.Forms.ToolStrip
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents Label1 As System.Windows.Forms.Label
    Private WithEvents _txtCampo_1 As System.Windows.Forms.TextBox
    Private WithEvents _lblDescripcion_3 As System.Windows.Forms.Label
    Public WithEvents UltraGroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLlimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Public WithEvents COBISResourceProvider As COBISCorp.Framework.UI.Components.COBISResourceProvider
    Private WithEvents commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    Friend WithEvents COBISStyleProvider As COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider
    Private WithEvents _txtCampo_4 As System.Windows.Forms.TextBox
    Friend WithEvents chkproducto As System.Windows.Forms.CheckBox
    Private WithEvents _lblDescripcion_6 As System.Windows.Forms.Label
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox

End Class
