include il "present/second_order/basic_gadgets.il"

macro calcG (w32 a_in, w32 b_in, w32 c_in, w32 d_in, w32 a_out, w32 b_out, w32 c_out, w32 d_out, w32 rnd_loc, int rnd_index)int indx
{
  indx <- rnd_index;
  secmult(b_in, d_in, rnd_loc, indx, d_out);
  indx <- indx +3;
  secmult(b_in, c_in, rnd_loc, indx, a_out);
  indx <- indx +3;
  secxor(a_out, a_in, a_out);
  /*calc a'*/
  secxor(a_out, d_out, a_out);

  /*calc d'*/
  secxor(c_in, d_out, d_out);
  
  /*calc b'*/
  secmult(a_in, b_in, rnd_loc, indx, b_out);
  indx <- indx +3;
  secxor(b_out, d_in, b_out);

  /*calc c'*/
  secstore(b_in, c_out);
 //secref(c_out, rnd_loc, 19, c_out);
}

macro calcB (w32 a_in, w32 b_in, w32 c_in, w32 d_in, w32 a_out, w32 b_out, w32 c_out, w32 d_out, w32 rnd_loc, int rnd_index)
{
  secxor(b_in, d_in, d_out);
  secxorone(d_out, d_out);
  secref(d_out, r3, rnd_index + 0, d_out);
  secstore(c_in, c_out);
  secref(c_out, r3, rnd_index + 6, c_out);
  secxor(b_in, c_in, b_out);
  secref(b_out, r3, rnd_index + 2, b_out);
  secxor(a_in, b_in, a_out);
  secref(a_out, r3, rnd_index + 4, a_out);

 
}

macro calcA (w32 a_in, w32 b_in, w32 c_in, w32 d_in, w32 a_out, w32 b_out, w32 c_out, w32 d_out, w32 rnd_loc, int rnd_index)int indx
{
  indx <- rnd_index;
  secxor(a_in, c_in, a_out);
  secxorone(b_in, b_out);
  secstore(a_in, c_out);
  secxor(a_in, c_in, d_out);
  secxor(d_out, d_in, d_out);
  secxorone(d_out, d_out);
}

macro calcB_opt (w32 a_in, w32 b_in, w32 c_in, w32 d_in, w32 a_out, w32 b_out, w32 c_out, w32 d_out, w32 rnd_loc, int rnd_index)
{
  load(r4, b_in, 0);
  load(r5, d_in, 0);
  xor(r5, r4);
  xor(r5, (w32) 255);
  load(r6, rnd_loc, 0 + rnd_index);
  xor(r5,r6);
  store(r5, d_out, 0);

  load(r6, a_in, 0);
  xor(r6, r4);
  load(r5, rnd_loc, 2 + rnd_index);
  xor(r6,r5);
  store(r6, a_out, 0);

  load(r5, c_in, 0);
  xor(r4, r5);
  load(r6,rnd_loc, 4 + rnd_index);
  xor(r4, r6);
  store(r4, b_out, 0);
  load(r6,rnd_loc, 6 + rnd_index);
  xor(r5, r6);
  store(r5, c_out, 0);

load_pub(r4);
load_pub(r5);
load_pub(r6);
clear_opA();
clear_opB();
clear_opR();
clear_opW();
  
  /*second share*/

  load(r4, b_in, 1);
  load(r5, d_in, 1);
  xor(r5, r4);
  load(r6,rnd_loc, 1 + rnd_index);
  xor(r5, r6);
  store(r5, d_out, 1);

  load(r6, a_in, 1);
  xor(r6, r4);
  load(r5,rnd_loc, 3 + rnd_index);
  xor(r6, r5);
  store(r6, a_out, 1);

  load(r5, c_in, 1);
  xor(r4, r5);
  load(r6,rnd_loc, 5 + rnd_index);
  xor(r4, r6);
  store(r4, b_out, 1);
  load(r6,rnd_loc, 7 + rnd_index);
  xor(r5, r6);
  store(r5, c_out, 1);

load_pub(r4);
load_pub(r5);
load_pub(r6);
clear_opA();
clear_opB();
clear_opR();
clear_opW();

  /*third share*/

  load(r4, b_in, 2);
  load(r5, d_in, 2);
  xor(r5, r4);
load_pub(r6);
  load(r6,rnd_loc, 0 + rnd_index);
clear_opR();
  load(r7,rnd_loc, 1 + rnd_index);
clear_opB();
  xor(r6, r7);
clear_opA();
clear_opB();
  xor(r5, r6);
  store(r5, d_out, 2);

  load(r6, a_in, 2);
  xor(r6, r4);
load_pub(r5);
  load(r5,rnd_loc, 2 + rnd_index);
clear_opR();
  load(r7,rnd_loc, 3 + rnd_index);
clear_opB();
  xor(r5, r7);
clear_opA();
clear_opB();
  xor(r6, r5);
  store(r6, a_out, 2);

  load(r5, c_in, 2);
clear_opB();
  xor(r4, r5);
load_pub(r6);
  load(r6,rnd_loc, 4 + rnd_index);
clear_opR();
  load(r7,rnd_loc, 5 + rnd_index);
clear_opB();
  xor(r6, r7);
clear_opA();
clear_opB();
  xor(r4, r6);
  store(r4, b_out, 2);

load_pub(r6);
  load(r6,rnd_loc, 6 + rnd_index);
clear_opR();
  load(r7,rnd_loc, 7 + rnd_index);
clear_opB();
  xor(r6, r7);
clear_opA();
clear_opB();
  xor(r5, r6);
  store(r5, c_out, 2);

  
load_pub(r4);
load_pub(r5);
load_pub(r6);
load_pub(r7);
clear_opA();
clear_opB();
clear_opR();
clear_opW();
}

macro calcA_opt (w32 a_in, w32 b_in, w32 c_in, w32 d_in, w32 a_out, w32 b_out, w32 c_out, w32 d_out, w32 rnd_loc, int rnd_index)
{ 
  load(r4, a_in, 0);
  store(r4,c_out,0);

  load(r5, c_in, 0);
  xor(r5, r4);
  store(r5, a_out, 0);
  
  xor(r5, (w32) 255);
  load(r6, d_in, 0);
  xor(r5, r6);
  store(r5, d_out, 0);

  load(r5, b_in, 0);
  xor(r5, (w32) 255);
  store(r5, b_out, 0);
  
  /*second share*/ 

  load(r5, a_in, 1);
  store(r5,c_out,1);
clear_opB();
  load(r4, c_in, 1);
  xor(r4, r4);
  store(r4, a_out, 1);
  
  load(r5, d_in, 1);
  xor(r4, r5);
  store(r4, d_out, 1);

  load(r5, b_in, 1);
  store(r5, b_out, 1);

  /*third share*/ 

  load(r5, a_in, 2);
  store(r5,c_out,2);
clear_opB();
  load(r4, c_in, 2);
  xor(r4, r4);
  store(r4, a_out, 2);
  
  load(r5, d_in, 2);
  xor(r4, r5);
  store(r4, d_out, 2);

  load(r5, b_in, 2);
  store(r5, b_out, 2);
  
load_pub(r4);
load_pub(r5);
load_pub(r6);
clear_opA();
clear_opB();
clear_opR();
clear_opW();
}




macro calcG_paraMult (w32 a_in, w32 b_in, w32 c_in, w32 d_in, w32 a_out, w32 b_out, w32 c_out, w32 d_out, w32 rnd_loc, int rnd_index)
{

  load(r4,b_in,0);
  load(r5,d_in,1);
  load(r6,c_in,1);
  load(r7,a_in,1);

  and(r5,r4);
  and(r6,r4);
  and(r7,r4);

  xor(r6,r5);

  load(r0, rnd_loc, rnd_index + 0);
  xor(r5,r0);
  load(r0, rnd_loc, rnd_index + 3);
  xor(r6,r0);
  load(r0, rnd_loc, rnd_index + 6);
  xor(r7,r0);

  load(r0,a_in,0);
  xor(r6,r0);
  and(r0,r4);
  xor(r7,r0);

  load(r0,c_in,0);
  xor(r5,r0);
  and(r0,r4);
  xor(r6,r0);

  load(r0,d_in,0);
  xor(r7, r0);
  and(r0,r4);
  xor(r5,r0);
  xor(r6,r0);

load_pub(r0);
clear_opR();	
  load(r0, rnd_loc, rnd_index + 1);
clear_opA();
clear_opB();
  xor(r5,r0);
  load(r0, rnd_loc, rnd_index + 4);
  xor(r6,r0);
  load(r0, rnd_loc, rnd_index + 7);
  xor(r7,r0);

  load(r0,a_in,2);
  and(r0,r4);
  xor(r7,r0);

  load(r0,c_in,2);
  and(r0,r4);
  xor(r6,r0);

  load(r0,d_in,2);
  and(r0,r4);
  xor(r5,r0);
  xor(r6,r0);


store(r6, a_out,0);
store(r7, b_out,0);
store(r4, c_out,0);
store(r5, d_out,0);

load_pub(r0);
load_pub(r5);
load_pub(r6);
load_pub(r4);
load_pub(r7);

clear_opR();
clear_opW();
clear_opA();
clear_opB();


  load(r4,b_in,1);
  load(r5,d_in,2);
  load(r6,c_in,2);
  load(r7,a_in,2);

  and(r5,r4);
  and(r6,r4);
  and(r7,r4);

  xor(r6,r5);

  load(r0, rnd_loc, rnd_index + 1);
  xor(r5,r0);
  load(r0, rnd_loc, rnd_index + 4);
  xor(r6,r0);
  load(r0, rnd_loc, rnd_index + 7);
  xor(r7,r0);

  load(r0,a_in,1);
  xor(r6,r0);
  and(r0,r4);
  xor(r7,r0);

  load(r0,c_in,1);
  xor(r5,r0);
  and(r0,r4);
  xor(r6,r0);

  load(r0,d_in,1);
  xor(r7, r0);
  and(r0,r4);
  xor(r5,r0);
  xor(r6,r0);

load_pub(r0);
clear_opR();	
  load(r0, rnd_loc, rnd_index + 2);
clear_opB();
clear_opA();
  xor(r5,r0);
  load(r0, rnd_loc, rnd_index + 5);
  xor(r6,r0);
  load(r0, rnd_loc, rnd_index + 8);
  xor(r7,r0);

  load(r0,a_in,0);
  and(r0,r4);
  xor(r7,r0);

  load(r0,c_in,0);
  and(r0,r4);
  xor(r6,r0);

  load(r0,d_in,0);
  and(r0,r4);
  xor(r5,r0);
  xor(r6,r0);

store(r6, a_out,1);
store(r7, b_out,1);
store(r4, c_out,1);
store(r5, d_out,1);

load_pub(r0);
load_pub(r5);
load_pub(r6);
load_pub(r4);
load_pub(r7);

clear_opR();
clear_opW();
clear_opA();
clear_opB();





  load(r4,b_in,2);
  load(r5,d_in,0);
  load(r6,c_in,0);
  load(r7,a_in,0);

  and(r5,r4);
  and(r6,r4);
  and(r7,r4);

  xor(r6,r5);

  load(r0, rnd_loc, rnd_index + 2);
  xor(r5,r0);
  load(r0, rnd_loc, rnd_index + 5);
  xor(r6,r0);
  load(r0, rnd_loc, rnd_index + 8);
  xor(r7,r0);

  load(r0,a_in,2);
  xor(r6,r0);
  and(r0,r4);
  xor(r7,r0);

  load(r0,c_in,2);
  xor(r5,r0);
  and(r0,r4);
  xor(r6,r0);

  load(r0,d_in,2);
  xor(r7, r0);
  and(r0,r4);
  xor(r5,r0);
  xor(r6,r0);

load_pub(r0);
clear_opR();	
  load(r0, rnd_loc, rnd_index + 0);
clear_opB();
clear_opA();
  xor(r5,r0);
  load(r0, rnd_loc, rnd_index + 3);
  xor(r6,r0);
  load(r0, rnd_loc, rnd_index + 6);
  xor(r7,r0);

  load(r0,a_in,1);
  and(r0,r4);
  xor(r7,r0);

  load(r0,c_in,1);
  and(r0,r4);
  xor(r6,r0);

  load(r0,d_in,1);
  and(r0,r4);
  xor(r5,r0);
  xor(r6,r0);

store(r6, a_out,2);
store(r7, b_out,2);
store(r4, c_out,2);
store(r5, d_out,2);

load_pub(r0);
load_pub(r5);
load_pub(r6);
load_pub(r4);
load_pub(r7);

clear_opR();
clear_opW();
clear_opA();
clear_opB();
}
