#pragma once

#include <string>

#define reg_period ((volatile uint32_t*) 0x43c00000)
#define reg_duty_cycle ((volatile uint32_t*) 0x43c00008)
#define reg_reset ((volatile uint32_t*) 0x43c0000c)
//#define reg_enable 0x43c0000c

namespace gui_dev_test_cpp {

	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;

	/// <summary>
	/// Summary for MyForm
	/// </summary>
	public ref class MyForm : public System::Windows::Forms::Form
	{
	public:
		MyForm(void)
		{
			InitializeComponent();
			//
			//TODO: Add the constructor code here
			//
		}

	protected:
		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		~MyForm()
		{
			if (components)
			{
				delete components;
			}
		}
	private: System::Windows::Forms::Button^  bt_reset;
	private: System::Windows::Forms::Button^  bt_enable;
	private: System::Windows::Forms::Button^  bt_generate_wave;
	private: System::Windows::Forms::Button^  button4;
	private: System::Windows::Forms::Label^  lb_period;
	private: System::Windows::Forms::Label^  lb_duty_cycle;
	private: System::Windows::Forms::TextBox^  tb_period;
	private: System::Windows::Forms::TextBox^  tb_duty_cycle;
	protected:

	private:
		/// <summary>
		/// Required designer variable.
		/// </summary>
		System::ComponentModel::Container ^components;

#pragma region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		void InitializeComponent(void)
		{
			this->bt_reset = (gcnew System::Windows::Forms::Button());
			this->bt_enable = (gcnew System::Windows::Forms::Button());
			this->bt_generate_wave = (gcnew System::Windows::Forms::Button());
			this->button4 = (gcnew System::Windows::Forms::Button());
			this->lb_period = (gcnew System::Windows::Forms::Label());
			this->lb_duty_cycle = (gcnew System::Windows::Forms::Label());
			this->tb_period = (gcnew System::Windows::Forms::TextBox());
			this->tb_duty_cycle = (gcnew System::Windows::Forms::TextBox());
			this->SuspendLayout();
			// 
			// bt_reset
			// 
			this->bt_reset->Location = System::Drawing::Point(12, 12);
			this->bt_reset->Name = L"bt_reset";
			this->bt_reset->Size = System::Drawing::Size(75, 23);
			this->bt_reset->TabIndex = 0;
			this->bt_reset->Text = L"Reset";
			this->bt_reset->UseVisualStyleBackColor = true;
			this->bt_reset->Click += gcnew System::EventHandler(this, &MyForm::bt_reset_Click);
			// 
			// bt_enable
			// 
			this->bt_enable->Location = System::Drawing::Point(93, 12);
			this->bt_enable->Name = L"bt_enable";
			this->bt_enable->Size = System::Drawing::Size(75, 23);
			this->bt_enable->TabIndex = 1;
			this->bt_enable->Text = L"Enable";
			this->bt_enable->UseVisualStyleBackColor = true;
			this->bt_enable->Click += gcnew System::EventHandler(this, &MyForm::bt_enable_Click);
			// 
			// bt_generate_wave
			// 
			this->bt_generate_wave->Location = System::Drawing::Point(12, 148);
			this->bt_generate_wave->Name = L"bt_generate_wave";
			this->bt_generate_wave->Size = System::Drawing::Size(113, 23);
			this->bt_generate_wave->TabIndex = 2;
			this->bt_generate_wave->Text = L"Generate Wave";
			this->bt_generate_wave->UseVisualStyleBackColor = true;
			this->bt_generate_wave->Click += gcnew System::EventHandler(this, &MyForm::bt_generate_wave_Click);
			// 
			// button4
			// 
			this->button4->Location = System::Drawing::Point(12, 41);
			this->button4->Name = L"button4";
			this->button4->Size = System::Drawing::Size(75, 23);
			this->button4->TabIndex = 3;
			this->button4->Text = L"tmp";
			this->button4->UseVisualStyleBackColor = true;
			this->button4->Click += gcnew System::EventHandler(this, &MyForm::button4_Click);
			// 
			// lb_period
			// 
			this->lb_period->AutoSize = true;
			this->lb_period->Location = System::Drawing::Point(12, 67);
			this->lb_period->Name = L"lb_period";
			this->lb_period->Size = System::Drawing::Size(37, 13);
			this->lb_period->TabIndex = 4;
			this->lb_period->Text = L"Period";
			this->lb_period->Click += gcnew System::EventHandler(this, &MyForm::lb_period_Click);
			// 
			// lb_duty_cycle
			// 
			this->lb_duty_cycle->AutoSize = true;
			this->lb_duty_cycle->Location = System::Drawing::Point(12, 106);
			this->lb_duty_cycle->Name = L"lb_duty_cycle";
			this->lb_duty_cycle->Size = System::Drawing::Size(58, 13);
			this->lb_duty_cycle->TabIndex = 5;
			this->lb_duty_cycle->Text = L"Duty Cycle";
			this->lb_duty_cycle->Click += gcnew System::EventHandler(this, &MyForm::lb_duty_cycle_Click);
			// 
			// tb_period
			// 
			this->tb_period->Location = System::Drawing::Point(12, 83);
			this->tb_period->Name = L"tb_period";
			this->tb_period->Size = System::Drawing::Size(100, 20);
			this->tb_period->TabIndex = 6;
			this->tb_period->TextChanged += gcnew System::EventHandler(this, &MyForm::tb_period_TextChanged);
			// 
			// tb_duty_cycle
			// 
			this->tb_duty_cycle->Location = System::Drawing::Point(12, 122);
			this->tb_duty_cycle->Name = L"tb_duty_cycle";
			this->tb_duty_cycle->Size = System::Drawing::Size(100, 20);
			this->tb_duty_cycle->TabIndex = 7;
			this->tb_duty_cycle->TextChanged += gcnew System::EventHandler(this, &MyForm::tb_duty_cycle_TextChanged);
			// 
			// MyForm
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->ClientSize = System::Drawing::Size(184, 180);
			this->Controls->Add(this->tb_duty_cycle);
			this->Controls->Add(this->tb_period);
			this->Controls->Add(this->lb_duty_cycle);
			this->Controls->Add(this->lb_period);
			this->Controls->Add(this->button4);
			this->Controls->Add(this->bt_generate_wave);
			this->Controls->Add(this->bt_enable);
			this->Controls->Add(this->bt_reset);
			this->Name = L"MyForm";
			this->Text = L"Rover GUI Tester";
			this->ResumeLayout(false);
			this->PerformLayout();

		}
#pragma endregion

private: System::Void bt_enable_Click(System::Object^  sender, System::EventArgs^  e) {
}
private: System::Void button4_Click(System::Object^  sender, System::EventArgs^  e) {
}
private: System::Void bt_generate_wave_Click(System::Object^  sender, System::EventArgs^  e) {
	*reg_reset = 0b10;
}
private: System::Void tb_duty_cycle_TextChanged(System::Object^  sender, System::EventArgs^  e) {
}
private: System::Void lb_period_Click(System::Object^  sender, System::EventArgs^  e) {
}
private: System::Void lb_duty_cycle_Click(System::Object^  sender, System::EventArgs^  e) {
	int duty_cycle = System::Convert::ToInt32(tb_duty_cycle->Text);
	*reg_duty_cycle = duty_cycle;
}
private: System::Void tb_period_TextChanged(System::Object^  sender, System::EventArgs^  e) {
	int period = System::Convert::ToInt32(tb_period->Text);
	*reg_period = period;
}
private: System::Void bt_reset_Click(System::Object^  sender, System::EventArgs^  e) {
	//Reset all values
	*reg_period = 0;
	*reg_duty_cycle = 0;
	*reg_reset = 0b01;

	for (int i = 0; i < 99999; i++)
	{
		//spin to waste time
	}

	//Turn off reset and turn on enable
	*reg_reset = 0b10;

}
};
}