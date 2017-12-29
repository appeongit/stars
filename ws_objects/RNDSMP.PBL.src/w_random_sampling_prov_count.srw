$PBExportHeader$w_random_sampling_prov_count.srw
$PBExportComments$Inherited from w_master
forward
global type w_random_sampling_prov_count from w_master
end type
type dw_1 from u_dw within w_random_sampling_prov_count
end type
type cb_1 from u_cb within w_random_sampling_prov_count
end type
end forward

global type w_random_sampling_prov_count from w_master
string accessiblename = "Random Sampling Counts"
string accessibledescription = "Random Sampling Counts"
accessiblerole accessiblerole = windowrole!
integer x = 0
integer y = 0
integer width = 3031
integer height = 1184
string title = "Random Sampling Counts"
windowtype windowtype = response!
long backcolor = 67108864
dw_1 dw_1
cb_1 cb_1
end type
global w_random_sampling_prov_count w_random_sampling_prov_count

type variables
// From message.powerobjectparm
sx_rand_samp_prov_count istr_prov_struct
end variables

event open;call super::open;// Katie	02/09/07	SPR 4754 Change the provider_id_t to get the text from the data structure
//									Removed "Provider" window titls

integer lv_upperbound,li_rc
long ll_rowcount,ll_rc
string ls_rc,ls_title

x = 1
y =10

ls_title = 'Random Sampling~r Counts by ' +  istr_prov_struct.ls_sample_selection 

ls_rc=dw_1.modify('rpt_title_t.text = ~'' + ls_title + '~'')

ls_rc = dw_1.modify('provider_id_t.text = ~'' + istr_prov_struct.ls_pit_label + '~'')

lv_upperbound = upperbound(istr_prov_struct.ls_provider_id)

for ll_rowcount = 1 to lv_upperbound
  ll_rc = dw_1.insertrow(0)
  li_rc = dw_1.SetItem ( ll_rowcount,1,istr_prov_struct.ls_provider_id[ll_rowcount] )   
  li_rc = dw_1.SetItem ( ll_rowcount,2,istr_prov_struct.ls_provider_name[ll_rowcount] )   
  li_rc = dw_1.SetItem ( ll_rowcount,3,istr_prov_struct.ll_provider_count[ll_rowcount])   
  li_rc = dw_1.SetItem ( ll_rowcount,4,istr_prov_struct.ll_provider_samplesize[ll_rowcount] )   
next


setmicrohelp(w_main,'Ready')
end event

on w_random_sampling_prov_count.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
end on

on w_random_sampling_prov_count.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
end on

event ue_preopen;call super::ue_preopen;
istr_prov_struct = message.Powerobjectparm
SetNull (message.Powerobjectparm)

end event

type dw_1 from u_dw within w_random_sampling_prov_count
string accessiblename = "Random Sample Provider Counts"
string accessibledescription = "Random Sample Provider Counts"
accessiblerole accessiblerole = clientrole!
integer x = 73
integer width = 2816
integer height = 928
integer taborder = 10
string dataobject = "d_random_sampling_prov_count"
boolean vscrollbar = true
end type

type cb_1 from u_cb within w_random_sampling_prov_count
string accessiblename = "Close"
string accessibledescription = "Close"
accessiblerole accessiblerole = pushbuttonrole!
integer x = 2597
integer y = 960
integer width = 274
integer height = 108
integer taborder = 20
string text = "&Close"
end type

on clicked;close(parent)
end on

