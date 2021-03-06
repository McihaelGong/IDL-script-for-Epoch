; ratio : energy transformation ration of each particles
; n     : the *sdf file the program get
; macro ; the macro partical number in theis simulation
; sum   : sum of the electron number in this simulation

pro r1018,n1,n2,part1,macro1,sum1

electronrate=dblarr(n2-n1+1)
protonrate=dblarr(n2-n1+1)
photonrate=dblarr(n2-n1+1)
positronrate=dblarr(n2-n1+1)
for i=n1,n2 do begin
print,'Start calculate energy  transformation ratio'
a=getdata(i,/en_electron,/grid_en_electron,/en_proton,/grid_en_proton,/en_photon,/grid_en_photon,/en_positron,/grid_en_positron,/total_particle_energy,/total_field_energy)
azc=getdata(1,/total_particle_energy,/total_field_energy)

numelectron  = a.en_electron
enelectron   = a.grid_en_electron.x
eenergy   = total(numelectron*enelectron)/part1*sum1/macro1
eaverage  = total(numelectron*enelectron)/total(numelectron)
enumber   = total(numelectron)/part1*sum1/macro1
numproton  = a.en_proton
enproton   = a.grid_en_proton.x
protonenergy   = total(numproton*enproton)/part1*sum1/macro1
protonaverage  = total(numproton*enproton)/total(numproton)
protonnumber   = total(numproton)/part1*sum1/macro1
numphoton    = a.en_photon
enphoton     = a.grid_en_photon.x
phenergy  = total(numphoton*enphoton)/part1*sum1/macro1
phaverage = total(numphoton*enphoton)/total(numphoton)
phnumber  = total(numphoton)/part1*sum1/macro1
numpositron    = a.en_positron
enpositron     = a.grid_en_positron.x
posienergy  = total(numpositron*enpositron)/part1*sum1/macro1
posiaverage = total(numpositron*enpositron)/total(numpositron)
posinumber  = total(numpositron)/part1*sum1/macro1
electronrate[i-n1]=eenergy/(eenergy+protonenergy+phenergy+posienergy)*(a.total_particle_energy-azc.total_particle_energy)/azc.total_field_energy
protonrate[i-n1]=protonenergy/(eenergy+protonenergy+phenergy+posienergy)*(a.total_particle_energy-azc.total_particle_energy)/azc.total_field_energy
photonrate[i-n1]=phenergy/(eenergy+protonenergy+phenergy+posienergy)*(a.total_particle_energy-azc.total_particle_energy)/azc.total_field_energy
positronrate[i-n1]=posienergy/(eenergy+protonenergy+phenergy+posienergy)*(a.total_particle_energy-azc.total_particle_energy)/azc.total_field_energy
endfor
save,electronrate,protonrate,photonrate,positronrate,filename='./rate.sav'
print,'ratio calculation finish,  OK !'
end 
