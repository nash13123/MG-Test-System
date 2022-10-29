
The microgrid test system is developed for the study on microgrid systemwide dynamics and control.
Xun Gong, ECE, McGill University, 2021.

1. The Data Acuisition and measurements in the simulation is adapted from the public matlab model by Leony Ortiz Matos:
https://www.mathworks.com/matlabcentral/fileexchange/73878-hybrid-ac-dc-dc-microgrid-test-system-simulation

Copyright (c) 2020, LEONY  ORTIZ MATOS
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution

* Neither the name of Universidad Politécnica Salesiana. nor the names of its
  contributors may be used to endorse or promote products derived from this
  software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.



2. The PV and Wind Generation are based on the MATLAB Built-in Examples. See:
https://www.mathworks.com/help/physmod/sps/ug/400-kw-grid-connected-pv-farm-average-model.html
https://www.mathworks.com/help/physmod/sps/ug/wind-farm-synchronous-generator-and-full-scale-converter-type-4-detailed-model.html
command: 
power_4PVarray_400kW; 
power_wind_type_4_avg



3. The Diesel Model is from a MATLAB built-in example:
https://www.mathworks.com/help/physmod/sps/ug/24-hour-simulation-of-a-vehicle-to-grid-v2g-system.html
command: power_V2G