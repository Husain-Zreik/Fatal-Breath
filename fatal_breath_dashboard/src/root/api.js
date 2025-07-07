/* eslint-disable no-useless-catch */
import { localStorageAction } from "../core/config/localstorage";
import { requestMethods } from "../core/enums/requestMethods";
import { sendRequest } from "../core/config/request";

export const RegisterUser = async (name, username, email, password, role) => {
  try {
    const response = await sendRequest({
      method: requestMethods.POST,
      route: "/auth/register",
      body: {
        name,
        username,
        email,
        role,
        password,
      },
    });

    localStorageAction("access_token", response.user.token);
    localStorageAction("user_data", response.user);
    return response;
  } catch (error) {
    throw error;
  }
};

export const Login = async (email, password) => {
  try {
    const response = await sendRequest({
      method: requestMethods.POST,
      route: "/auth/login",
      body: {
        email,
        password,
      },
    });

    localStorageAction("access_token", response.user.token);
    localStorageAction("user_data", response.user);

    return response;
  } catch (error) {
    throw error;
  }
};

export const loadStat = async () => {
  try {
    const response = await sendRequest({
      method: requestMethods.GET,
      route: "/user/admin/overview",
    });

    return response;
  } catch (error) {
    throw error;
  }
};

export const createHouse = async (name, city, country) => {
  try {
    const response = await sendRequest({
      method: requestMethods.POST,
      route: "/user/admin/add-house",
      body: {
        name,
        city,
        country,
      },
    });

    return response;
  } catch (error) {
    throw error;
  }
};

export const loadHouses = async () => {
  try {
    const response = await sendRequest({
      method: requestMethods.GET,
      route: "/user/admin/get-houses",
    });

    return response;
  } catch (error) {
    throw error;
  }
};

export const loadMembers = async () => {
  try {
    const response = await sendRequest({
      method: requestMethods.GET,
      route: "/user/admin/members",
    });

    return response;
  } catch (error) {
    throw error;
  }
};

export const deleteMember = async (houseId, memberId) => {
  try {
    const response = await sendRequest({
      method: requestMethods.DELETE,
      route: `/user/admin/${houseId}/member/${memberId}`,
    });

    return response;
  } catch (error) {
    throw error;
  }
};

export const createRoom = async (name, house_id, type) => {
  try {
    const response = await sendRequest({
      method: requestMethods.POST,
      route: "/user/admin/add-room",
      body: {
        name,
        house_id,
        type,
      },
    });

    console.log("Room created:", response);

    return response.room;
  } catch (error) {
    throw error;
  }
};
export const loadRooms = async () => {
  try {
    const response = await sendRequest({
      method: requestMethods.GET,
      route: "/user/admin/get-rooms",
    });

    return response;
  } catch (error) {
    throw error;
  }
};
export const deleteRoom = async (roomId) => {
  try {
    const response = await sendRequest({
      method: requestMethods.DELETE,
      route: `/user/admin/room/${roomId}`,
    });

    return response;
  } catch (error) {
    throw error;
  }
};

export const deleteHouse = async (houseId) => {
  try {
    const response = await sendRequest({
      method: requestMethods.DELETE,
      route: `/user/admin/house/${houseId}`,
    });

    return response;
  } catch (error) {
    throw error;
  }
};

export const loadRoomsFromAdminHouses = async (houseId) => {
  try {
    const response = await sendRequest({
      method: requestMethods.GET,
      route: "/user/admin/get-houses",
    });

    const houses = response.houses || [];
    const house = houses.find((h) => h.id === parseInt(houseId));

    if (!house) return [];

    const rooms = house.rooms.map((room) => ({
      ...room,
      houseName: house.name,
    }));

    return rooms;
  } catch (error) {
    throw error;
  }
};

export const toggleInvitation = async (houseId, userId) => {
  try {
    const response = await sendRequest({
      method: requestMethods.POST,
      route: "/user/admin/toggle-invitation",
      body: {
        house_id: houseId,
        user_id: userId,
      },
    });

    return response;
  } catch (error) {
    throw error;
  }
};

export const proccessRequest = async (houseId, userId, status) => {
  try {
    const response = await sendRequest({
      method: requestMethods.POST,
      route: "/user/admin/process-request",
      body: {
        house_id: houseId,
        user_id: userId,
        status,
      },
    });

    return response;
  } catch (error) {
    throw error;
  }
};

export const searchUsers = async (houseId, username) => {
  try {
    const response = await sendRequest({
      method: requestMethods.POST,
      route: "/user/admin/search",
      body: {
        house_id: houseId,
        username,
      },
    });

    return response;
  } catch (error) {
    throw error;
  }
};

export const loadRequests = async () => {
  try {
    const response = await sendRequest({
      method: requestMethods.GET,
      route: "/user/admin/memberships",
    });

    return response;
  } catch (error) {
    throw error;
  }
};
