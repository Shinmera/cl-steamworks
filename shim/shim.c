#include <stdint.h>
#include "isteamcontroller.h"
extern "C"{
  // FIXME: do this, also don't forget to include in extra.json
  /* void shim_SteamAPI_ISteamNetworking_CreateConnectionSocket(ISteamNetworking *self,){ */
    
  /* } */
  
  /* void shim_SteamAPI_ISteamNetworking_CreateListenSocket(ISteamNetworking *self,){ */
    
  /* } */
  
  /* void shim_SteamAPI_ISteamParties_GetBeaconLocationData(ISteamParties *self,){ */
    
  /* } */
  
  void shim_SteamAPI_ISteamInput_GetDigitalActionData(ISteamInput *self, InputHandle_t controller, InputDigitalActionHandle_t action, InputDigitalActionData_t *out){
    InputDigitalActionData_t in = self->GetDigitalActionData(controller, action);
    out->bState = in.bState;
    out->bActive = in.bActive;
  }
  
  void shim_SteamAPI_ISteamInput_GetAnalogActionData(ISteamInput *self, InputHandle_t controller, InputAnalogActionHandle_t action, InputAnalogActionData_t *out){
    InputAnalogActionData_t in = self->GetAnalogActionData(controller, action);
    out->eMode = in.eMode;
    out->x = in.x;
    out->y = in.y;
    out->bActive = in.bActive;
  }
  
  void shim_SteamAPI_ISteamInput_GetMotionData(ISteamInput *self, InputHandle_t controller, InputMotionData_t *out){
    InputMotionData_t in = self->GetMotionData(controller);
    out->rotQuatX = in.rotQuatX;
    out->rotQuatY = in.rotQuatY;
    out->rotQuatZ = in.rotQuatZ;
    out->rotQuatW = in.rotQuatW;
    out->posAccelX = in.posAccelX;
    out->posAccelY = in.posAccelY;
    out->posAccelZ = in.posAccelZ;
    out->rotVelX = in.rotVelX;
    out->rotVelY = in.rotVelY;
    out->rotVelZ = in.rotVelZ;
  }
  
  void shim_ISteamController_GetDigitalActionData(ISteamController *self, ControllerHandle_t controller, ControllerDigitalActionHandle_t action, InputDigitalActionData_t *out){
    InputDigitalActionData_t in = self->GetDigitalActionData(controller, action);
    out->bState = in.bState;
    out->bActive = in.bActive;
  }

  void shim_ISteamController_GetAnalogActionData(ISteamController *self, ControllerHandle_t controller, ControllerAnalogActionHandle_t action, InputAnalogActionData_t *out){
    InputAnalogActionData_t in = self->GetAnalogActionData(controller, action);
    out->eMode = in.eMode;
    out->x = in.x;
    out->y = in.y;
    out->bActive = in.bActive;
  }

  void shim_ISteamController_GetMotionData(ISteamController *self, ControllerHandle_t controller, struct InputMotionData_t *out){
    InputMotionData_t in = self->GetMotionData(controller);
    out->rotQuatX = in.rotQuatX;
    out->rotQuatY = in.rotQuatY;
    out->rotQuatZ = in.rotQuatZ;
    out->rotQuatW = in.rotQuatW;
    out->posAccelX = in.posAccelX;
    out->posAccelY = in.posAccelY;
    out->posAccelZ = in.posAccelZ;
    out->rotVelX = in.rotVelX;
    out->rotVelY = in.rotVelY;
    out->rotVelZ = in.rotVelZ;
  }
}
