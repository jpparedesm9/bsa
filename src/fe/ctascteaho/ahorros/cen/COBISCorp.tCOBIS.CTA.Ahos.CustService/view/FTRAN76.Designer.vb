<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FTRAN76Class
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

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTRAN76Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.PForma = New Infragistics.Win.Misc.UltraGroupBox()
        Me.mskValor = New COBISCorp.Framework.UI.Components.COBISMaskedInBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.txtMonDescripcion = New System.Windows.Forms.TextBox()
        Me.txtMonCodigo = New System.Windows.Forms.TextBox()
        Me.txtNombre = New System.Windows.Forms.TextBox()
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.TSBotones.SuspendLayout()
        CType(Me.PForma, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PForma.SuspendLayout()
        Me.SuspendLayout()
        '
        'COBISViewResizer
        '
        Me.COBISViewResizer.AutoRelocateControls = False
        Me.COBISViewResizer.AutoResizeControls = False
        Me.COBISViewResizer.EnabledResize = True
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBTransmitir, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(554, 25)
        Me.TSBotones.TabIndex = 0
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBTransmitir.Image = CType(resources.GetObject("TSBTransmitir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBTransmitir.Name = "TSBTransmitir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.Size = New System.Drawing.Size(86, 22)
        Me.TSBTransmitir.Text = "*&Transmitir"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBLimpiar.Image = CType(resources.GetObject("TSBLimpiar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBLimpiar.Name = "TSBLimpiar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.Size = New System.Drawing.Size(72, 22)
        Me.TSBLimpiar.Text = "*&Limpiar"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1006")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'PForma
        '
        Me.PForma.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.COBISViewResizer.SetAutoRelocate(Me.PForma, False)
        Me.COBISViewResizer.SetAutoResize(Me.PForma, False)
        Me.PForma.BackColorInternal = System.Drawing.Color.White
        Me.PForma.Controls.Add(Me.mskValor)
        Me.PForma.Controls.Add(Me.Label2)
        Me.PForma.Controls.Add(Me.Label1)
        Me.PForma.Controls.Add(Me.txtMonDescripcion)
        Me.PForma.Controls.Add(Me.txtMonCodigo)
        Me.PForma.Controls.Add(Me.txtNombre)
        Me.PForma.Controls.Add(Me.mskCuenta)
        Me.PForma.Controls.Add(Me._lblEtiqueta_0)
        Me.PForma.Controls.Add(Me._lblEtiqueta_6)
        Me.COBISStyleProvider.SetControlStyle(Me.PForma, "Default")
        Me.PForma.Location = New System.Drawing.Point(8, 33)
        Me.PForma.Name = "PForma"
        Me.PForma.Size = New System.Drawing.Size(537, 124)
        Me.PForma.TabIndex = 1
        Me.PForma.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PForma, "")
        '
        'mskValor
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskValor, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskValor, False)
        Me.mskValor.BackColor = System.Drawing.SystemColors.Window
        Me.mskValor.ClipMode = COBISCorp.Framework.UI.Components.ENUM_CLIPMODE.Include_Literals_on_cut_copy
        Me.mskValor.ClipText = "0.00"
        Me.COBISStyleProvider.SetControlStyle(Me.mskValor, "Default")
        Me.mskValor.Cuantas = 0
        Me.mskValor.DateString = "_.$"
        Me.mskValor.DateSybase = Nothing
        Me.mskValor.Decimals = CType(2, Short)
        Me.mskValor.Errores = CType(0, Short)
        Me.mskValor.Fin = 6
        Me.mskValor.FormattedText = Nothing
        Me.mskValor.HelpLine = Nothing
        Me.mskValor.hWnd = 0
        Me.mskValor.Location = New System.Drawing.Point(168, 92)
        Me.mskValor.Mask = " "
        Me.mskValor.MaxReal = 1.0E+15!
        Me.mskValor.MinReal = 0.0!
        Me.mskValor.Name = "mskValor"
        Me.mskValor.Nullable = False
        Me.mskValor.Separator = True
        Me.mskValor.Size = New System.Drawing.Size(147, 20)
        Me.mskValor.StringIndex = CType(0, Short)
        Me.mskValor.TabIndex = 4
        Me.mskValor.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskValor, "")
        '
        'Label2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label2, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label2, False)
        Me.Label2.AutoSize = True
        Me.Label2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label2, "Default")
        Me.Label2.ForeColor = System.Drawing.Color.Navy
        Me.Label2.Location = New System.Drawing.Point(11, 95)
        Me.Label2.Name = "Label2"
        Me.COBISResourceProvider.SetResourceID(Me.Label2, "509509")
        Me.Label2.Size = New System.Drawing.Size(82, 13)
        Me.Label2.TabIndex = 17
        Me.Label2.Text = "*Valor de retiro :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label2, "")
        '
        'Label1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label1, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label1, False)
        Me.Label1.AutoSize = True
        Me.Label1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label1, "Default")
        Me.Label1.ForeColor = System.Drawing.Color.Navy
        Me.Label1.Location = New System.Drawing.Point(11, 69)
        Me.Label1.Name = "Label1"
        Me.COBISResourceProvider.SetResourceID(Me.Label1, "5209")
        Me.Label1.Size = New System.Drawing.Size(56, 13)
        Me.Label1.TabIndex = 14
        Me.Label1.Text = "*Moneda :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label1, "")
        '
        'txtMonDescripcion
        '
        Me.txtMonDescripcion.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.COBISViewResizer.SetAutoRelocate(Me.txtMonDescripcion, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtMonDescripcion, False)
        Me.COBISStyleProvider.SetControlStyle(Me.txtMonDescripcion, "Default")
        Me.txtMonDescripcion.Location = New System.Drawing.Point(204, 66)
        Me.txtMonDescripcion.Name = "txtMonDescripcion"
        Me.txtMonDescripcion.ReadOnly = True
        Me.txtMonDescripcion.Size = New System.Drawing.Size(314, 20)
        Me.txtMonDescripcion.TabIndex = 3
        Me.txtMonDescripcion.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtMonDescripcion, "")
        '
        'txtMonCodigo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.txtMonCodigo, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtMonCodigo, False)
        Me.COBISStyleProvider.SetControlStyle(Me.txtMonCodigo, "Default")
        Me.txtMonCodigo.Location = New System.Drawing.Point(168, 66)
        Me.txtMonCodigo.Name = "txtMonCodigo"
        Me.txtMonCodigo.ReadOnly = True
        Me.txtMonCodigo.Size = New System.Drawing.Size(30, 20)
        Me.txtMonCodigo.TabIndex = 2
        Me.txtMonCodigo.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtMonCodigo, "")
        '
        'txtNombre
        '
        Me.txtNombre.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.COBISViewResizer.SetAutoRelocate(Me.txtNombre, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtNombre, False)
        Me.COBISStyleProvider.SetControlStyle(Me.txtNombre, "Default")
        Me.txtNombre.Location = New System.Drawing.Point(168, 40)
        Me.txtNombre.Name = "txtNombre"
        Me.txtNombre.ReadOnly = True
        Me.txtNombre.Size = New System.Drawing.Size(350, 20)
        Me.txtNombre.TabIndex = 1
        Me.txtNombre.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtNombre, "")
        '
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Length = CType(64, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(168, 14)
        Me.mskCuenta.MaxReal = 3.402823E+38!
        Me.mskCuenta.MinReal = -3.402823E+38!
        Me.mskCuenta.Name = "mskCuenta"
        Me.mskCuenta.Size = New System.Drawing.Size(147, 20)
        Me.mskCuenta.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuenta, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.AutoSize = True
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(11, 17)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "501874")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(128, 13)
        Me._lblEtiqueta_0.TabIndex = 7
        Me._lblEtiqueta_0.Text = "*Num. de cuenta ahorros:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        '_lblEtiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_6, False)
        Me._lblEtiqueta_6.AutoSize = True
        Me._lblEtiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_6, "Default")
        Me._lblEtiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(11, 43)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "500108")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(113, 13)
        Me._lblEtiqueta_6.TabIndex = 8
        Me._lblEtiqueta_6.Text = "*Nombre de la cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        'FTRAN76Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.Color.White
        Me.Controls.Add(Me.PForma)
        Me.Controls.Add(Me.TSBotones)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Name = "FTRAN76Class"
        Me.Size = New System.Drawing.Size(554, 167)
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.PForma, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PForma.ResumeLayout(False)
        Me.PForma.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents COBISViewResizer As COBISCorp.eCOBIS.Commons.COBISViewResizer
    Public WithEvents COBISResourceProvider As COBISCorp.Framework.UI.Components.COBISResourceProvider
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents PForma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents mskValor As COBISCorp.Framework.UI.Components.COBISMaskedInBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents txtMonDescripcion As System.Windows.Forms.TextBox
    Friend WithEvents txtMonCodigo As System.Windows.Forms.TextBox
    Friend WithEvents txtNombre As System.Windows.Forms.TextBox
    Public WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Friend WithEvents COBISStyleProvider As COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider

End Class
