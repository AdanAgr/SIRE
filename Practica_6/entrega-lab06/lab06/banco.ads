with Cuenta;
use Cuenta;

package Banco is
   type Banco_Tipo is private;

   function Crear_Banco return Banco_Tipo;
   procedure Agregar_Cuenta(B : in out Banco_Tipo; C : Cuenta_Bancaria);
   procedure Transferir(B : in out Banco_Tipo; Origen, Destino : String; Monto : Float);
   function Consultar_Cuenta(B : Banco_Tipo; Titular : String) return Cuenta_Bancaria;
   function Consultar_Saldo_Banco(B : Banco_Tipo) return Float;
   procedure Actualizar_Cuenta(B : in out Banco_Tipo; C : Cuenta_Bancaria);

private
   Max_Cuentas : constant Integer := 10;
   type Lista_Cuentas is array (1..Max_Cuentas) of Cuenta_Bancaria;
   type Banco_Tipo is record
      Cuentas : Lista_Cuentas;
      Total   : Integer := 0;
   end record;
end Banco;
