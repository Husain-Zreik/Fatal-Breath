import React, { useState, useEffect } from 'react';

const UserManagement = () => {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Fetch users from API
    const fetchUsers = async () => {
      try {
        // Replace with actual API call
        const mockUsers = [
          { id: 1, name: 'Admin User', email: 'admin@example.com', role: 'admin' },
          { id: 2, name: 'Manager User', email: 'manager@example.com', role: 'manager' },
          { id: 3, name: 'Regular User', email: 'user@example.com', role: 'user' },
        ];
        setUsers(mockUsers);
        setLoading(false);
      } catch (error) {
        console.error('Error fetching users:', error);
        setLoading(false);
      }
    };

    fetchUsers();
  }, []);

  const handleDelete = (userId) => {
    // Delete user logic
    setUsers(users.filter(user => user.id !== userId));
  };

  if (loading) return <div>Loading...</div>;

  return (
    <div>
      <h3>User Management</h3>
      <button>Add User</button>
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Role</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {users.map(user => (
            <tr key={user.id}>
              <td>{user.id}</td>
              <td>{user.name}</td>
              <td>{user.email}</td>
              <td>{user.role}</td>
              <td>
                <button>Edit</button>
                <button onClick={() => handleDelete(user.id)}>Delete</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default UserManagement;