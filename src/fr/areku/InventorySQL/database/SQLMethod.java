package fr.areku.InventorySQL.database;

import org.bukkit.command.CommandSender;

import fr.areku.InventorySQL.InventorySQL;

public abstract class SQLMethod implements Runnable {
	private long CURRENT_CHECK_EPOCH = 0;
	private CommandSender cs = null;
	private String initiator = null;
	private JDCConnection conn = null;
	private CoreSQLProcess parent;
	private Object target;

	public abstract void doAction(Object target, String initiator, CommandSender cs);

	public long getCurrentCheckEpoch() {
		return CURRENT_CHECK_EPOCH;
	}	
	public JDCConnection getConn() {
		return conn;
	}
	public String getInitiator() {
		return initiator;
	}
	public CoreSQLProcess getCoreSQL() {
		return parent;
	}

	public void sendMessage(String msg) {
		if (cs != null) {
			cs.sendMessage(msg);
		}
	}

	public SQLMethod(CoreSQLProcess parent, String initiator, CommandSender cs) {
		this.parent = parent;
		this.cs = cs;
		this.initiator = initiator;
	}
	
	public SQLMethod setTarget(Object target){
		this.target = target;
		return this;
	}

	@Override
	public void run() {
		CURRENT_CHECK_EPOCH = System.currentTimeMillis() / 1000L;
		try {
			if (!this.parent.isDatabaseReady()) {
				conn = null;
				InventorySQL.d("Database isn't ready");
				return;
			}
			if (conn == null) {
				conn = this.parent.getConnection();
			} else {
				if (!conn.isValid())
					conn = this.parent.getConnection();
			}
			doAction(target, initiator, cs); // real action is here
		} catch (Exception ex) {
			if (parent.isDatabaseReady()) {
				InventorySQL.logException(ex,
						"exception in playerlogic - check all");
			}
		}
		if (conn != null)
			conn.close();
	}
}
